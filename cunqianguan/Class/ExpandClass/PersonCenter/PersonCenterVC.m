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
#import "MyOrderScrollVC.h"
#import "AccountVC.h"
#import "RunningWaterScrollVC.h"
#import "AddressManagerVC.h"
#import "CollectVC.h"
#import "MessageInfoVC.h"
#import "InviteVC.h"
#import "MoreSettingVC.h"
#import "PersonInfoVC.h"
#import "TipInfoVC.h"
#import "CallsRechargeVC.h"
#import "BMAlert.h"

#import "SignVC.h"
#import "PersonInfo.h"
#import "PersonConnect.h"
#import "BaseConnect.h"
@interface PersonCenterVC ()<PersonHeaderDelegate,PersonFooterDelegate>
{
    NSDictionary *_localData;
    PersonHeaderView *personHeaderView;
    PersonFooterView *personFooterView;
    PersonInfo *_info;
}

@end
static NSString *CellID = @"PersonInfoCell";
static NSString *FooterViewID = @"PersonFooterView";
@implementation PersonCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _localData = @{@"0":@[@"现金",@"淘宝集分宝",@"我的积分"],@"1":@[@"我的订单",@"账户明细"],@"2":@[@"收款账号",@"收货地址"],@"3":@[@"邀请好友",@"话费充值",@"更多"]};
    [self setUpNavBtn];
    [self setUpTableView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self reloadView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)reloadView
{
    _info = [PersonInfo sharedPersonInfo];
    [personHeaderView loadView:_info];
    [personFooterView loadView:_info];
    [self.tableView reloadData];
    [self initSignStatus];
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
    [self setRigthBarWithDic:@{@"images":@[@"sign"]}];
}

-(void)setUpTableView
{
    [self createTableWithStye:UITableViewStyleGrouped];
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGTH - 64);
    
    UINib *cellNib = [UINib nibWithNibName:@"PersonInfoCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:CellID];
    
    personHeaderView = [PersonHeaderView headerView];
    personHeaderView.delegate = self;
    self.tableView.tableHeaderView = personHeaderView;
    
    
    personFooterView = [PersonFooterView footerView];
    personFooterView.delegate = self;
    personFooterView.backgroundColor = self.tableView.backgroundColor;
    self.tableView.tableFooterView = personFooterView;
    
    [self popView:personHeaderView.progressView.frame];
}

-(void)rightBtnClick:(UIButton *)btn
{
    SignVC *signVC = [[SignVC alloc] init];
    signVC.leftTitle = @"每日签到";
    [self.navigationController pushViewController:signVC animated:YES];
}

-(void)popView:(CGRect)frame
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    view.backgroundColor = [UIColor redColor];
    [view setCenter:CGPointMake(frame.size.width/2 + 30, frame.origin.y - view.frame.size.height/2)];
    [self.tableView addSubview:view];
}


-(void)initSignStatus
{
    NSString *userId = _info.userId?_info.userId:@"";
    [[PersonConnect sharedPersonConnect] initSignStatus:userId success:^(id json) {
        NSDictionary *dic = (NSDictionary *)json;
        if ([BaseConnect isSucceeded:dic]) {
            _info.isSignToday = [[dic objectForKey:@"data"] boolValue];
            [_info saveUserData];
        }
    } failure:^(NSError *err) {
        
    }];
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
    cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    cell.titleLabel.text = [_localData objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section]][indexPath.row];
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                cell.infoLabel.text = [NSString stringWithFormat:@"%ld元",(long)_info.cashAll];
                break;
            case 1:
                cell.infoLabel.text = [NSString stringWithFormat:@"%ld个",(long)_info.pointTb];
                break;
            case 2:
                cell.infoLabel.text = [NSString stringWithFormat:@"%ld分",(long)_info.pointSite];
                break;
        }
    }else{
        cell.infoLabel.hidden = YES;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_info isLoginWithPresent:^(BOOL flag) {
        switch (indexPath.section) {
            case 0:
                [self pushMoneyViewWith:indexPath];
                break;
            case 1:
                if(indexPath.row == 0){
                    MyOrderScrollVC *myOrderScrollVC = [[MyOrderScrollVC alloc] init];
                    myOrderScrollVC.leftTitle = [_localData objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section]][indexPath.row];
                    [self.navigationController pushViewController:myOrderScrollVC animated:YES];
                }else if (indexPath.row == 1){
                    RunningWaterScrollVC *accountInfoVC = [[RunningWaterScrollVC alloc] init];
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
                    InviteVC *inviteVC = [[InviteVC alloc] init];
                    inviteVC.leftTitle = [_localData objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section]][indexPath.row];
                    [self.navigationController pushViewController:inviteVC animated:YES];
                }else if (indexPath.row == 1){
                    CallsRechargeVC *callsRechargeVC = [[CallsRechargeVC alloc] init];
                    callsRechargeVC.leftTitle = [_localData objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section]][indexPath.row];
                    [self.navigationController pushViewController:callsRechargeVC animated:YES];
                }else if (indexPath.row == 2){
                    MoreSettingVC *moreSettingVC = [[MoreSettingVC alloc] init];
                    moreSettingVC.leftTitle = [_localData objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section]][indexPath.row];
                    [self.navigationController pushViewController:moreSettingVC animated:YES];
                }
                break;
        }
    } WithType:YES];
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
            [self pushCollection];
            break;
        case 1001:
            [self pushMsgInfo];
            break;
        default:
            break;
    }
}

-(void)pushCollection
{
    [_info isLoginWithPresent:^(BOOL flag) {
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        [flowLayout setSectionInset:UIEdgeInsetsMake(10, 5, 5, 5)];
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 10.0;
        
        CollectVC *collectVC = [[CollectVC alloc] initWithCollectionViewLayout:flowLayout];
        collectVC.leftTitle = @"收藏";
        [self.navigationController pushViewController:collectVC animated:YES];
    } WithType:YES];
}

-(void)pushMsgInfo
{
    [_info isLoginWithPresent:^(BOOL flag) {
        MessageInfoVC *messageVC = [[MessageInfoVC alloc] init];
        messageVC.leftTitle = @"消息";
        [self.navigationController pushViewController:messageVC animated:YES];
    } WithType:YES];
}

-(void)tapHeadImage
{
    [_info isLoginWithPresent:^(BOOL flag) {
        PersonInfoVC *personInfoVC = [[PersonInfoVC alloc] init];
        personInfoVC.leftTitle = @"个人信息";
        [self.navigationController pushViewController:personInfoVC animated:YES];
    } WithType:YES];
}

#pragma mark -- PersonFooterDelegate
-(void)helpInfoClick
{
    TipInfoVC *infoVC = [[TipInfoVC alloc] init];
    infoVC.leftTitle = @"帮助中心";
    [infoVC reloadDataWith:@{@"title":@"什么是累计获得金额？",@"info":@"累计获得金额等于（积分+集分宝+现金）收入的总和！\n其中100积分等同于1元钱\n100集分宝等同于1元钱"}];
    [self.navigationController pushViewController:infoVC animated:YES];
}

-(void)loginOutClick
{
    [[BMAlert sharedBMAlert] alert:@"确认退出？" cancle:^(DoAlertView *alertView) {
        [_info loginOut];
        [self reloadView];
    } other:^(DoAlertView *alertView) {
        
    }];
}

@end
