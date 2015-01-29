//
//  PersonCenterVC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/24.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "PersonCenterVC.h"
#import "PersonInfoCell.h"
#import "PersonHeaderView.h"
#import "PersonFooterView.h"

#import "MoneyViewVC.h"
#import "MyOrderVC.h"
#import "AccountVC.h"
#import "RunningWaterVC.h"
#import "AddressManagerVC.h"
#import "MessageInfoVC.h"
#import "MoreSettingVC.h"

@interface PersonCenterVC ()<PersonHeaderDelegate>
{
    NSDictionary *_localData;
}

@end
static NSString *CellID = @"PersonInfoCell";
static NSString *FooterViewID = @"PersonFooterView";
@implementation PersonCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _localData = @{@"0":@[@"现金",@"淘宝集分宝",@"我的积分"],@"1":@[@"我的订单",@"账户明细"],@"2":@[@"收款账号",@"收货地址"],@"3":@[@"邀请好友",@"更多"]};
    [self setTitleText:@"会员中心"];
    [self setUpNavBtn];
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
-(void)setUpNavBtn
{
    [self setRigthBarWithDic:@{@"images":@[@"refresh"],@"imageshover":@[@"refresh_hover"]}];
}

-(void)setUpTableView
{
    [self createTableWithStye:UITableViewStyleGrouped];
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGTH - 64);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UINib *cellNib = [UINib nibWithNibName:@"PersonInfoCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:CellID];
    
    PersonHeaderView *personHeaderView = [PersonHeaderView headerView];
    personHeaderView.delegate = self;
    self.tableView.tableHeaderView = personHeaderView;
    
    PersonFooterView *personFooterView = [PersonFooterView footerView];
    personFooterView.backgroundColor = self.tableView.backgroundColor;
    self.tableView.tableFooterView = personFooterView;
    
    [self popView:personHeaderView.progressView.frame];
}

-(void)popView:(CGRect)frame
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    view.backgroundColor = [UIColor redColor];
    [view setCenter:CGPointMake(frame.size.width/2, frame.origin.y - view.frame.size.height/2)];
    [self.tableView addSubview:view];
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
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    PersonInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    cell.titleLabel.text = [_localData objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section]][indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            [self pushMoneyViewWith:indexPath];
            break;
        case 1:
            if(indexPath.row == 0){
                MyOrderVC *myOrderVC = [[MyOrderVC alloc] init];
                myOrderVC.leftTitle = [_localData objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section]][indexPath.row];
                [self.navigationController pushViewController:myOrderVC animated:YES];
            }else if (indexPath.row == 1){
                RunningWaterVC *accountInfoVC = [[RunningWaterVC alloc] init];
                accountInfoVC.leftTitle = [_localData objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section]][indexPath.row];
                [self.navigationController pushViewController:accountInfoVC animated:YES];
            }
            break;
        case 2:
            if (indexPath.row == 0) {
                AccountVC *accountVC = [[AccountVC alloc] init];
                accountVC.leftTitle = [_localData objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section]][indexPath.row];
                [self.navigationController pushViewController:accountVC animated:YES];
            }else if (indexPath.row == 1){
                AddressManagerVC *addressManagerVC = [[AddressManagerVC alloc] init];
                addressManagerVC.leftTitle = [_localData objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section]][indexPath.row];
                [self.navigationController pushViewController:addressManagerVC animated:YES];
            }
            break;
        case 3:
            if (indexPath.row == 0) {
                
            }else if (indexPath.row == 1){
                MoreSettingVC *moreSettingVC = [[MoreSettingVC alloc] init];
                moreSettingVC.leftTitle = [_localData objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section]][indexPath.row];
                [self.navigationController pushViewController:moreSettingVC animated:YES];
            }
            break;
        default:
            break;
    }
}

-(void)pushMoneyViewWith:(NSIndexPath *)indexPath
{
    MoneyViewVC *moneyViewVC = [[MoneyViewVC alloc] init];
    moneyViewVC.type = indexPath.row;
    moneyViewVC.leftTitle = [_localData objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section]][indexPath.row];
    [self.navigationController pushViewController:moneyViewVC animated:YES];
}

#pragma MARK -- PersonHeaderDelegate
-(void)btnAction:(NSInteger)tag
{
    switch (tag) {
        case 1000:
            break;
        case 1001:
            [self pushMsgInfo];
            break;
        default:
            break;
    }
}

-(void)pushMsgInfo
{
    MessageInfoVC *messageVC = [[MessageInfoVC alloc] init];
    messageVC.leftTitle = @"消息";
    [self.navigationController pushViewController:messageVC animated:YES];
}
@end
