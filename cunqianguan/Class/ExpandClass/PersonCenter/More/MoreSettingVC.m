//
//  MoreSettingVC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/28.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "MoreSettingVC.h"
#import "SignatureVC.h"
#import "HelpInfoVC.h"
#import "MsgSetVC.h"
#import "AboutUsVC.h"
@interface MoreSettingVC ()
{
    NSDictionary *_localData;
    NSDictionary *_localImageData;
}

@end

@implementation MoreSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _localData = @{@"0":@[/*@"检查更新",*/@"意见反馈",@"帮助中心",@"消息设置"],@"1":@[@"清理缓存",@"关于我们"]};
    _localImageData = @{@"0":@[/*@"more_01",*/@"more_02",@"more_03",@"more_04"],@"1":@[@"more_05",@"more_06"]};
    [self setUpTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];
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
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGTH - 64);
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

#pragma mark -- UITableViewDataSource && UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _localData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[_localData objectForKey:[NSString stringWithFormat:@"%ld",(long)section]] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    return 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section != 0) {
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
        bgView.backgroundColor = UIColorFromRGB(0xececec);
        return bgView;
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellID = @"MoreCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
        if (!iOS7) {
            UIView *bgView =  [[UIView alloc] initWithFrame:cell.frame];
            bgView.backgroundColor = [UIColor whiteColor];
            cell.backgroundView = bgView;
        }
    }
    cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    NSString *imageName = [_localImageData objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section]][indexPath.row];
    cell.imageView.image = [UIImage imageNamed:imageName];
    cell.textLabel.font = [UIFont systemFontOfSize:15.0f];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = [_localData objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section]][indexPath.row];
    
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = UIColorFromRGB(0xbcbcbc);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = indexPath.row;
    if (indexPath.section == 0) {
        if(index == 0){
            SignatureVC *signatureVC = [[SignatureVC alloc] init];
            signatureVC.leftTitle = @"意见反馈";
            [self.navigationController pushViewController:signatureVC animated:YES];
        }else if(index == 1){
            HelpInfoVC *helpInfoVC = [[HelpInfoVC alloc] init];
            helpInfoVC.leftTitle = @"帮助中心";
            [self.navigationController pushViewController:helpInfoVC animated:YES];
        }else if(index == 2){
            MsgSetVC *msgSetVC = [[MsgSetVC alloc] init];
            msgSetVC.leftTitle = @"消息设置";
            [self.navigationController pushViewController:msgSetVC animated:YES];
        }
    }else if (indexPath.section == 1){
        if(index == 0){
            [self clearCache];
        }else if(index == 1){
            AboutUsVC *aboutUseVC = [[AboutUsVC alloc] init];
            aboutUseVC.leftTitle = @"关于我们";
            [self.navigationController pushViewController:aboutUseVC animated:YES];
        }
    }
   
}

-(void)clearCache
{
    [self showHUD:ACTION_LOAD];
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        [self hideAllHUD];
        [self showStringHUD:@"清理成功" second:1];
        [self.tableView reloadData];
    }];
    [[SDImageCache sharedImageCache] clearMemory];
}

@end
