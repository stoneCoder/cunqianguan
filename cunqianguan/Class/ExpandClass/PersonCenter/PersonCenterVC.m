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
#import "PopTipView.h"

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

#import "RedBagView.h"
#import "RedBagOpenView.h"

#import "SignVC.h"
#import "PersonInfo.h"
#import "PersonConnect.h"
#import "BaseConnect.h"
#import "BaseUtil.h"
@interface PersonCenterVC ()<PersonHeaderDelegate,PersonFooterDelegate,RedBagViewDelegate,RedBagOpenViewDelegate>
{
    NSDictionary *_localData;
    PersonHeaderView *personHeaderView;
    PersonFooterView *personFooterView;
    PersonInfo *_info;
    PopTipView *_popTipView;
    UIButton *_rightButton;
    RedBagView *_redBagView;
    RedBagOpenView *_redBagOpenView;
    BOOL _isNewOrder;
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
    [self setUpRedBag];
    [self setUpRedBagOpen];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self reloadView];
    if (_isRegistFinish) {
        [self showStringHUD:@"注册成功" second:1.5];
    }
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"rewardNotice"] boolValue]) {
        [self showRedBagView:_redBagView];
    }else{
        [self.view bringSubviewToFront:self.tableView];
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    _isRegistFinish = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)reloadView
{
    _info = [PersonInfo sharedPersonInfo];
    if (_info.userId) {
        NSInteger oldMsgCount = _info.messageCount;
        NSInteger oldOrderCount = _info.orderCount;

        [_info getUserInfo:_info.email withPwd:[_info getAccountPassword:_info.email] success:^(id json) {
            NSDictionary *dic = (NSDictionary *)json;
            if ([BaseConnect isSucceeded:dic]) {
                if (oldMsgCount < _info.messageCount) {
                    personHeaderView.pointImageView.hidden = NO;
                }else{
                    personHeaderView.pointImageView.hidden = YES;
                }
                if (oldOrderCount < _info.orderCount) {
                    _isNewOrder = YES;
                }else{
                    _isNewOrder = NO;
                }
                [personHeaderView loadView:_info];
                [personFooterView loadView:_info];
                [self.tableView reloadData];
            }
        } failure:^(id json) {
            
        }];
    }else{
        [personHeaderView loadView:_info];
        [personFooterView loadView:_info];
        [self.tableView reloadData];
    }
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
    _rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0,0,22,22)];
    [_rightButton setBackgroundImage:[UIImage imageNamed:@"sign"] forState:UIControlStateNormal];
    [_rightButton setBackgroundImage:[UIImage imageNamed:@"sign_down"] forState:UIControlStateHighlighted];
    [_rightButton addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc] initWithCustomView:_rightButton];
    self.navigationItem.rightBarButtonItem = rightBtnItem;
}

-(void)setUpTableView
{
    [self createTableWithStye:UITableViewStylePlain];
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
}

-(void)setUpRedBag
{
    _redBagView = [RedBagView initBagView];
    _redBagView.delegate = self;
    _redBagView.hidden = YES;
    [self.view insertSubview:_redBagView belowSubview:self.tableView];
}

-(void)setUpRedBagOpen
{
    _redBagOpenView = [RedBagOpenView initBagOpenView];
    _redBagOpenView.delegate = self;
    _redBagOpenView.hidden = YES;
    [self.view insertSubview:_redBagOpenView belowSubview:self.tableView];
}

-(void)rightBtnClick:(UIButton *)btn
{
    [_info isLoginWithPresent:^(BOOL flag) {
        SignVC *signVC = [[SignVC alloc] init];
        signVC.leftTitle = @"每日签到";
        [self.navigationController pushViewController:signVC animated:YES];
    } WithType:YES];
}


//-(void)setUpProgressView
//{
//    if (_info.userId) {
//        [self popView:personHeaderView.progressView.frame];
//    }
//}
//
//-(void)popView:(CGRect)frame
//{
//    CGFloat height = 20.0f;
//    UIFont *font = [UIFont systemFontOfSize:12.0f];
//    NSString *str = [NSString stringWithFormat:@"%ld/%ld",(long)_info.userExp,(long)_info.nextUserExp];
//    CGFloat width = [BaseUtil getWidthByString:str font:font allheight:height andMaxWidth:150];
//    if (!_popTipView) {
//        _popTipView = [[PopTipView alloc] initWithFrame:CGRectMake(0, 0, 200, height)];
//    }
//    [_popTipView loadViewWith:str];
//    [_popTipView setCenter:CGPointMake(frame.size.width - width/2, frame.origin.y - _popTipView.frame.size.height/2)];
//    [personHeaderView addSubview:_popTipView];
//}


-(void)initSignStatus
{
    NSString *userId = _info.userId?_info.userId:@"";
    [[PersonConnect sharedPersonConnect] initSignStatus:userId success:^(id json) {
        NSDictionary *dic = (NSDictionary *)json;
        if ([BaseConnect isSucceeded:dic]) {
            _info.isSignToday = [[dic objectForKey:@"data"] boolValue];
            if (_info.isSignToday) {
                [_rightButton setBackgroundImage:[UIImage imageNamed:@"sign_over"] forState:UIControlStateNormal];
                [_rightButton setBackgroundImage:[UIImage imageNamed:@"sign_overdown"] forState:UIControlStateHighlighted];
            }else{
                [_rightButton setBackgroundImage:[UIImage imageNamed:@"sign"] forState:UIControlStateNormal];
                [_rightButton setBackgroundImage:[UIImage imageNamed:@"sign_down"] forState:UIControlStateHighlighted];
            }
            [_info saveUserData];
        }
    } failure:^(NSError *err) {
        
    }];
}

#pragma mark -- RedBagViewDelegate
-(void)closeRedBagView
{
    [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"rewardNotice"];
    [self hideRedBagView:_redBagView andDuration:0.25f];
}

-(void)tapToOpenRedBag
{
    [[PersonConnect sharedPersonConnect] tapOpenRedBag:_info.userId success:^(id json) {
        NSDictionary *dic = (NSDictionary *)json;
        if ([BaseConnect isSucceeded:dic]) {
            [self hideRedBagView:_redBagView andDuration:0.1f];
            [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"rewardNotice"];
            [self showRedBagView:_redBagOpenView];
        }
    } failure:^(NSError *err) {
        
    }];
}

#pragma mark -- RedBagOpenViewDelegate
-(void)closeOpenView
{
    [self hideRedBagView:_redBagOpenView andDuration:0.25f];
}

-(void)inviteFriend
{
    InviteVC *inviteVC = [[InviteVC alloc] init];
    inviteVC.leftTitle = @"邀请好友";
    [self.navigationController pushViewController:inviteVC animated:YES];
}

-(void)hideRedBagView:(UIView *)view andDuration:(CGFloat)duration
{
    CATransition *animation = [CATransition animation];
    [animation setDuration:duration];
    [animation setType:kCATransitionFade];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [view.layer addAnimation:animation forKey:nil];
    view.hidden = YES;
    [self.view bringSubviewToFront:self.tableView];
}

-(void)showRedBagView:(UIView *)view
{
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.25f];
    [animation setType:kCATransitionFade];
    [animation setFillMode:kCAFillModeForwards];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [view.layer addAnimation:animation forKey:nil];
    view.hidden = NO;
    [self.view bringSubviewToFront:view];
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
    if (section == 0) {
        return nil;
    }else{
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
        bgView.backgroundColor = UIColorFromRGB(0xececec);
        return bgView;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PersonInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    
    if (!iOS7) {
        UIView *bgView =  [[UIView alloc] initWithFrame:cell.frame];
        bgView.backgroundColor = [UIColor whiteColor];
        cell.backgroundView = bgView;
    }
    
    cell.titleLabel.text = [_localData objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section]][indexPath.row];
    switch (indexPath.section) {
        case 0:
            cell.infoLabel.hidden = NO;
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
            break;
        case 1:
            if (indexPath.row == 0 && _isNewOrder) {
                cell.poingImage.hidden = NO;
            }
            break;
        default:
            cell.poingImage.hidden = YES;
            cell.infoLabel.hidden = YES;
            break;
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
                    addressManagerVC.isExChange = NO;
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
        _popTipView.hidden = YES;
        _popTipView = nil;
        [_popTipView removeFromSuperview];
        [self.navigationController popToRootViewControllerAnimated:YES];
    } other:^(DoAlertView *alertView) {
        
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 20;
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

@end
