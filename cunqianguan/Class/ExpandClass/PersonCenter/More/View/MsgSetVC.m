//
//  MsgSetVC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/3/10.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "MsgSetVC.h"
#import "MsgSetCell.h"
#import "BaseUtil.h"

#import "TGCCustomPickerView.h"
@interface MsgSetVC ()<MsgSetCellDelegate,TGCCustomPickerViewDelegate>
{
    NSArray *_localData;
    TGCCustomPickerView *_pickerView;
    BOOL _ifShowPicerView;
}

@end
static NSString *msgSetCellId = @"MsgSetCell";
@implementation MsgSetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if ([BaseUtil isInstallApp:@"taobao://"]) {
        _localData = @[@"用淘宝客户端打开",@"消息提醒",@"通知时段"];
    }else{
        _localData = @[@"消息提醒",@"通知时段"];
    }
    [self setUpTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUpTableView
{
    [self createTableWithStye:UITableViewStylePlain];
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGTH - 64);
    
    UINib *cellNib = [UINib nibWithNibName:@"MsgSetCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:msgSetCellId];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark -- UITableViewDataSource && UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _localData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MsgSetCell *cell = [tableView dequeueReusableCellWithIdentifier:msgSetCellId];
    cell.tag = indexPath.row;
    NSString *title = _localData[indexPath.row];
    cell.titleLabel.text = title;
    if (!iOS7) {
        UIView *bgView =  [[UIView alloc] initWithFrame:cell.frame];
        bgView.backgroundColor = [UIColor whiteColor];
        cell.backgroundView = bgView;
    }
    if (indexPath.row == _localData.count - 1) {
        cell.switchBtn.hidden = YES;
        cell.infoLabel.hidden = NO;
    }
    if ([title isEqualToString:@"用淘宝客户端打开"]) {
        cell.switchBtn.selected = [[[NSUserDefaults standardUserDefaults] objectForKey:@"taobaoclient"] boolValue];
    }
    if ([title isEqualToString:@"消息提醒"]) {
        cell.switchBtn.selected = [[[NSUserDefaults standardUserDefaults] objectForKey:@"msgTip"] boolValue];
    }
    if ([title isEqualToString:@"通知时段"] && !cell.infoLabel.hidden) {
        cell.infoLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"clickTime"];
    }else{
        cell.infoLabel.text = @"7:00-23:59";
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == _localData.count - 1) {
        NSMutableArray *firstArray = [NSMutableArray array];
        NSMutableArray *secondArray = [NSMutableArray array];
        for (int i = 0; i < 24; i++) {
            [firstArray addObject:[NSString stringWithFormat:@"%.2d",i]];
        }
        for (int j = 0; j < 60; j++) {
            [secondArray addObject:[NSString stringWithFormat:@"%.2d",j]];
        }
        NSDictionary *dic = @{@"0":firstArray,@"1":secondArray,@"2":firstArray,@"3":secondArray};
        [self showPicker:dic];
    }
}

#pragma mark --  MsgSetCellDelegate
-(void)tapSwitch:(MsgSetCell *)cell
{
    NSString *isTaobao;
    NSString *isMsg;
    if ([cell.switchBtn isSelected]) {
        isTaobao = @"NO";
        isMsg = @"NO";
        cell.switchBtn.selected = NO;
    }else{
        isTaobao = @"YES";
        isMsg = @"YES";
        cell.switchBtn.selected = YES;
    }
    NSString *text = cell.titleLabel.text;
    if ([text isEqualToString:@"用淘宝客户端打开"]){
        [[NSUserDefaults standardUserDefaults] setObject:isTaobao forKey:@"taobaoclient"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }else if ([text isEqualToString:@"消息提醒"]) {
        [[NSUserDefaults standardUserDefaults] setObject:isMsg forKey:@"msgTip"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

#pragma mark -- Private
-(void)showPicker:(NSDictionary *)data
{
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    if (_pickerView) {
        [_pickerView dismiss];
        _pickerView = nil;
    }
    
    _pickerView = [[TGCCustomPickerView alloc] initWithFrame:CGRectMake(0, height, self.view.bounds.size.width, 280) andPickerViewType:kTGCPickerViewTypeCustom andComponents:4];
    _pickerView.componentDics = [NSMutableDictionary dictionaryWithDictionary:data];
    _pickerView.delegate = self;
    [self.view addSubview:_pickerView];
    [_pickerView show];
}

#pragma mark - TGCCustomPickerViewDelegate
- (void)didPickerView:(UIPickerView *)pickerView selectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i < _pickerView.components; i++) {
        NSInteger rowCount = [pickerView selectedRowInComponent:i];
        [array addObject:[NSString stringWithFormat:@"%ld", (long)rowCount]];
    }
    [_pickerView forDataShowingStringWithRowsCount:array];
}

- (void)didShowPickerView:(UIView *)pickerView {
    _ifShowPicerView = YES;
    
}

- (void)didDismissPickerView {
    _ifShowPicerView = NO;
}

- (void)didFinishPicker {
    _ifShowPicerView = NO;
    NSString *str= _pickerView.showingString;
    if (str.length > 0) {
        NSString *firstTime = [NSString stringWithFormat:@"%@:%@",[str substringWithRange:NSMakeRange(0, 2)],[str substringWithRange:NSMakeRange(2, 2)]];
        
        NSString *secondTime = [NSString stringWithFormat:@"%@:%@",[str substringWithRange:NSMakeRange(4, 2)],[str substringWithRange:NSMakeRange(6, 2)]];

        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@-%@",firstTime,secondTime] forKey:@"clickTime"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self.tableView reloadData];
    }
    
}
@end
