//
//  PersonInfoVC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/30.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "PersonInfoVC.h"
#import "ProfileCell.h"
#import "PointView.h"

#import "IBActionSheet.h"
#import "VPImageCropperVC.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface PersonInfoVC ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate,VPImageCropperDelegate,IBActionSheetDelegate>

@end
static NSString *ProfileCellID = @"ProfileCell";
@implementation PersonInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setUpTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)setUpTableView
{
    [self createTableWithStye:UITableViewStylePlain];
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, VIEW_HEIGHT - 64);
    self.tableView.scrollEnabled = NO;

    UINib *CellNib = [UINib nibWithNibName:@"ProfileCell" bundle:nil];
    [self.tableView registerNib:CellNib forCellReuseIdentifier:ProfileCellID];
   
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT - 108)];
    footerView.backgroundColor = UIColorFromRGB(0XECECEC);
    PointView *pointView = [[PointView alloc] initWithFrame:CGRectMake(20, 40, SCREEN_WIDTH - 40, 220) style:UITableViewStylePlain];
    if (iOS7) {
        [pointView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    pointView.delegate = pointView;
    pointView.dataSource = pointView;
    pointView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    pointView.scrollEnabled = NO;
    [footerView addSubview:pointView];
    self.tableView.tableFooterView = footerView;
}

#pragma mark -- UITableViewDataSource && UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ProfileCell *cell = [tableView dequeueReusableCellWithIdentifier:ProfileCellID];
    cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        IBActionSheet *actionSheet = [[IBActionSheet alloc] initWithTitle:@"设置头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从相册选择照片" , nil];
        [actionSheet showInView:self.view];
    }
}

#pragma mark - Actionsheet delegate
-(void)actionSheet:(IBActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            // 拍照
            if ([self isCameraAvailable] && [self doesCameraSupportTakingPhotos]) {
                UIImagePickerController *controller = [[UIImagePickerController alloc] init];
                controller.sourceType = UIImagePickerControllerSourceTypeCamera;
                if ([self isFrontCameraAvailable]) {
                    controller.cameraDevice = UIImagePickerControllerCameraDeviceFront;
                }
                NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
                [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
                controller.mediaTypes = mediaTypes;
                controller.delegate = self;
                [self presentViewController:controller
                                                  animated:YES
                                                completion:NULL];
            }
            break;
       case 1:
            // 从相册中选取
            if ([self isPhotoLibraryAvailable]) {
                UIImagePickerController *controller = [[UIImagePickerController alloc] init];
                controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
                [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
                controller.mediaTypes = mediaTypes;
                controller.delegate = self;
                [self presentViewController:controller
                                                  animated:YES
                                                completion:NULL];
            }
            break;
        default:
            break;
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^() {
        UIImage *portraitImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        // 裁剪
        VPImageCropperVC *imgEditorVC = [[VPImageCropperVC alloc] initWithImage:portraitImg cropFrame:CGRectMake(0, 64.0f, VIEW_WIDTH, VIEW_HEIGHT) limitScaleRatio:3.0];
        imgEditorVC.delegate = self;
        [self presentViewController:imgEditorVC animated:YES completion:NULL];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^(){
    }];
}

#pragma mark VPImageCropperDelegate
- (void)imageCropper:(VPImageCropperVC *)cropperViewController didFinished:(UIImage *)editedImage {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    ProfileCell *cell = (ProfileCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    cell.headImageView.image = editedImage;
    [cropperViewController dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imageCropperDidCancel:(VPImageCropperVC *)cropperViewController {
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
    }];
}

#pragma mark camera utility
- (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isRearCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

- (BOOL) isFrontCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

- (BOOL) doesCameraSupportTakingPhotos {
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable:
            UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickVideosFromPhotoLibrary{
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickPhotosFromPhotoLibrary{
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (BOOL) cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType{
    __block BOOL result = NO;
    if ([paramMediaType length] == 0) {
        return NO;
    }
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaType]){
            result = YES;
            *stop= YES;
        }
    }];
    return result;
}

@end
