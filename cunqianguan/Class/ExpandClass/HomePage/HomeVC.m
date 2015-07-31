//
//  HomeVC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/19.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "HomeVC.h"
#import "TapActionView.h"
#import "MenuCell.h"
#import "GridMenu.h"

#import "AdvertisingView.h"
#import "SMPageControl.h"
#import "SDCycleScrollView.h"
#import "PresentTableView.h"
#import "ReturnHomeVC.h"
#import "RebateHomeVC.h"
#import "PolyDealVC.h"
#import "FootPrintsVC.h"
#import "ExChangeCenterVC.h"
#import "PersonCenterVC.h"
#import "HotShopVC.h"
#import "SearchViewVC.h"
#import "InviteVC.h"
#import "MyOrderScrollVC.h"
#import "SignVC.h"
#import "NotificationWebVC.h"

#import "PresentView.h"
#import "BaseMutableMenu.h"
#import "GoodsViewVC.h"
#import "PolyScrollVC.h"
#import "ExChangeScrollVC.h"
#import "PresentTableFooterView.h"
#import "JMHoledView.h"

#import "LoginVC.h"
#import "BaseNC.h"

#import "Constants.h"
#import "BaseConnect.h"
#import "HomeConnect.h"
#import "AdListModel.h"
#import "AdModel.h"
#import "PersonInfo.h"
#import "UIImage+Resize.h"
#import "PopoverView.h"
#import "BMAlert.h"

#import "AppDelegate.h"


@interface HomeVC ()<TapActionViewDelegate,GridMenuDeleage,PresentViewDelegate,JMHoledViewDelegate>
{
    UIScrollView *_scrollView;
    TapActionView *_actionView;
    UIView *_dimView;
    GridMenu *_gridMenu;
    //ScrollFocus *_pageControl;
    NSInteger _openView;
    PersonInfo *_info;
    PresentView *_presentView;
    SDCycleScrollView *_pageControl;
    JMHoledView *_holedView;
    BOOL _homeTip;
}

@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _info = [PersonInfo sharedPersonInfo];
    [self hideReturnBtn];
    [self initNavBar];
    [self initScrollView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushPersonCenter:) name:kRegistFinish object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushNotificationView:) name:kNotificationPush object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushHomeTipView:) name:kHomeTipShow object:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_info loadUserData];
    [self initAdView];
    [self initActionView];
    _actionView.tipImage.hidden = ![_info isNewTrace];
    [self hideMenu];
//    if (_dimView) {
//        [_dimView removeFromSuperview];
//        _dimView = nil;
//        _openView = 0;
//    }
}

-(void)viewDidAppear:(BOOL)animated{
//    dispatch_async(dispatch_get_global_queue(0, 0), ^(void){
//        [self loadAdView];
//    });
    
    [self initPresentView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kRegistFinish object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationPush object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kHomeTipShow object:nil];
}

-(void)initNavBar
{
    [self setLeftBtnWithImage:@{@"nomarl":@"more_home",@"highlight":@"more_home_down"}];
    //设置navigationbar右边按钮
    UIButton *rigthButton = [[UIButton alloc] initWithFrame:CGRectMake(0,0,22,22)];
    [rigthButton setBackgroundImage:[UIImage imageNamed:@"right_search"] forState:UIControlStateNormal];
    [rigthButton setBackgroundImage:[UIImage imageNamed:@"right_search_hover"] forState:UIControlStateHighlighted];
    [rigthButton addTarget:self action:@selector(searchAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc] initWithCustomView:rigthButton];
    self.navigationItem.rightBarButtonItem = rightBtnItem;
    
    //设置导航栏内容
    [self setTitleImage:[UIImage imageNamed:@"logo"]];
}

-(void)initScrollView
{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGTH - 64)];
    [_scrollView setContentSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGTH - 63)];
    [self.view addSubview:_scrollView];
}

/*-(void)initAdView
{
    _pageControl =  [[ScrollFocus alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, VIEW_HEIGHT - SCREEN_WIDTH)];
    
    
    if (SCREEN_HEIGTH == 480) {
        _pageControl.imageArray = @[@"banner4_01",@"banner4_02"];
    }else if (SCREEN_HEIGTH == 568){
        _pageControl.imageArray = @[@"banner5_01",@"banner5_02"];
    }else if (SCREEN_HEIGTH == 667){
        _pageControl.imageArray = @[@"banner1",@"banner2"];
    }else if (SCREEN_HEIGTH == 736){
        _pageControl.imageArray = @[@"banner6p_01",@"banner6p_02"];
    }
    _pageControl.titleArray = @[@"banner1",@"banner2"];
    _pageControl.autoScroll = YES;
    [_pageControl didSelectScrollFocusItem:^(NSInteger index) {
        switch (index) {
            case 0:
                [self inviteFriend];
                break;
            case 1:
                [self presentHelpView];
                break;
        }
    }];
  
    [_scrollView addSubview:_pageControl];
}*/

-(void)initAdView
{
    NSArray *imageArray;
    if (SCREEN_HEIGTH == 480) {
        imageArray = @[@"banner4_01",@"banner4_02"];
    }else if (SCREEN_HEIGTH == 568){
        imageArray = @[@"banner5_01",@"banner5_02"];
    }else if (SCREEN_HEIGTH == 667){
        imageArray = @[@"banner1",@"banner2"];
    }else if (SCREEN_HEIGTH == 736){
        imageArray = @[@"banner6p_01",@"banner6p_02"];
    }
    _pageControl = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGTH - 64 - SCREEN_WIDTH) imagesGroup:imageArray];
    _pageControl.autoScrollTimeInterval = 5.0f;
    _pageControl.dotImage = [UIImage imageNamed:@"qiehuan_home"];
    _pageControl.currentDotImage = [UIImage imageNamed:@"qiehuan_hover"];
    [_scrollView addSubview:_pageControl];
    
    __weak HomeVC *weakSelf = self;
    _pageControl.selectItemBlock = ^(NSInteger index){
        switch (index) {
            case 0:
                [weakSelf inviteFriend];
                break;
            case 1:
                [weakSelf presentHelpView];
                break;
        }
    };
}

-(void)initActionView
{
    CGFloat visiableY =   _pageControl.frame.size.height;
    _actionView = [TapActionView init];
    [_actionView setFrame:CGRectMake(0, visiableY, SCREEN_WIDTH, SCREEN_WIDTH)];
    _actionView.delegate = self;
    [_scrollView addSubview:_actionView];
}

-(void)initPresentView
{
    _presentView = [[PresentView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGTH, SCREEN_WIDTH, SCREEN_HEIGTH)];
    _presentView.delegate = self;
    _presentView.hidden = YES;
    [self.view.window addSubview:_presentView];
}

-(void)initHoledView
{
    _holedView = [[JMHoledView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGTH)];
    _holedView.holeViewDelegate = self;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:_holedView];
    
    [self initTaoTipView:_holedView WithParentView:window];
    
}

-(void)initTaoTipView:(JMHoledView *)holedView WithParentView:(UIWindow *)window
{
    CGRect taoFrame = _actionView.taobaoView.frame;
    CGRect frame = [_actionView.taobaoView convertRect:CGRectZero toView:window];
    
    UIView *view = [[UIView alloc] init];
    view.layer.borderWidth = 2.0f;
    view.layer.borderColor = [UIColor whiteColor].CGColor;
    view.backgroundColor = [UIColor clearColor];
    [holedView addHCustomView:view onRect:CGRectMake(frame.origin.x, frame.origin.y, taoFrame.size.width, taoFrame.size.height)isBorder:YES];
    
    UIImageView *taoImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"taobao_tishi"]];
    CGRect fanligouFrame = [_actionView.fanligouView convertRect:CGRectZero toView:window];
    [holedView addHCustomView:taoImage onRect:CGRectMake(fanligouFrame.origin.x , fanligouFrame.origin.y - 50, taoImage.frame.size.width, taoImage.frame.size.height)];
}

-(void)initZujiView:(JMHoledView *)holedView WithParentView:(UIWindow *)window
{
    CGRect zujiFrame = _actionView.zujiView.frame;
    CGRect frame = [_actionView.zujiView convertRect:CGRectZero toView:window];
    
    UIView *view = [[UIView alloc] init];
    view.layer.borderWidth = 2.0f;
    view.layer.borderColor = [UIColor whiteColor].CGColor;
    view.backgroundColor = [UIColor clearColor];
    [holedView addHCustomView:view onRect:CGRectMake(frame.origin.x, frame.origin.y, zujiFrame.size.width, zujiFrame.size.height)isBorder:YES];
    
    UIImageView *zujiImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"zuji_tishi"]];
    CGRect fanligouFrame = [_actionView.juyouhuiView convertRect:CGRectZero toView:window];
    [holedView addHCustomView:zujiImage onRect:CGRectMake(fanligouFrame.origin.x , fanligouFrame.origin.y - 50, zujiImage.frame.size.width, zujiImage.frame.size.height)];
}

-(void)loadAdView
{
    NSDictionary *dic = [NSDictionary dictionary];
    [[HomeConnect sharedHomeConnect] getIndexAdWith:dic success:^(id json) {
        NSDictionary *dic = (NSDictionary *)json;
        if ([BaseConnect isSucceeded:dic]) {
            AdListModel *adListModel = [[AdListModel alloc] initWithDictionary:dic error:nil];
            for (int i = 0; i < adListModel.data.count; i++) {
                AdModel *adModel = adListModel.data[i];
                AdvertisingView *adView = [[AdvertisingView alloc] initWithFrame:CGRectZero];
                [adView.imageView sd_setImageWithURL:[NSURL URLWithString:adModel.pic_url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    [image imageByScalingAndCroppingForSize:_pageControl.frame.size];
                }];
            }
        }
    } failure:^(NSError *err) {
        
    }];
}

#pragma mark - JMHoledViewDelegate

- (void)holedView:(JMHoledView *)holedView didSelectHoleAtIndex:(NSUInteger)index
{
    if (index == 1 && !_homeTip) {
        [holedView removeHoles];
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [self initZujiView:holedView WithParentView:window];
        _homeTip = YES;
    }else if (index == 1 && _homeTip){
        [holedView removeFromSuperview];
        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"homeTip"];
    }
}

#pragma mark -- Private
- (void)searchAction:(id)sender
{
    SearchViewVC *searchVC = [[SearchViewVC alloc] init];
    [self.navigationController pushViewController:searchVC animated:YES];
}

- (void)leftBtnClicked:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    CGPoint point = CGPointMake(CGRectGetWidth(btn.frame)/2 + btn.frame.origin.x, btn.frame.origin.y + btn.frame.size.height + 32);
    PopoverView *pop = [[PopoverView alloc] initWithPoint:point titles:@[@"每日签到",@"我的订单",@"邀请好友"] images:@[@"sign_more",@"order_more",@"invite_more"] selectImage:@[@"sign_more_down",@"order_more_down",@"invite_more_down"]];
    pop.layer.cornerRadius = 5.0f;
    pop.layer.masksToBounds = YES;
    pop.selectRowAtIndex = ^(NSInteger index){
        switch (index) {
            case 0:
                /*每日签到*/
                [self pushToSign];
                break;
            case 1:
                /*我的订单*/
                [self pushToMyOrder];
                break;
            case 2:
                /*邀请好友*/
                [self pushToInvite];
                break;
        }
    };
    [pop show];

    //_openView = 1;
    //[self showMenu:_openView];
}

-(void)hideMenu
{
    [self dismissMenu:_openView];
}

#pragma mark -- Private
-(void)pushToSign
{
    [_info isLoginWithcompletion:^(BOOL flag) {
        SignVC *signVC = [[SignVC alloc] init];
        signVC.leftTitle = @"每日签到";
        [self.navigationController pushViewController:signVC animated:YES];
    }];
}

-(void)pushToMyOrder
{
    [_info isLoginWithcompletion:^(BOOL flag) {
        MyOrderScrollVC *myOrderScrollVC = [[MyOrderScrollVC alloc] init];
        myOrderScrollVC.leftTitle = @"我的订单";
        [self.navigationController pushViewController:myOrderScrollVC animated:YES];
    }];
}

-(void)pushToInvite
{
    [_info isLoginWithcompletion:^(BOOL flag) {
        InviteVC *inviteVC = [[InviteVC alloc] init];
        inviteVC.leftTitle = @"邀请好友";
        [self.navigationController pushViewController:inviteVC animated:YES];
    }];
}

#pragma mark -- PresentViewDelegate
-(void)presentHelpView
{
    [UIView animateWithDuration:0.25f animations:^{
        _presentView.hidden = NO;
        [_presentView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGTH)];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.25f animations:^{
            _presentView.closeBtn.transform = CGAffineTransformMakeRotation(M_PI/2);
        } completion:^(BOOL finished) {
            
        }];
    }];
}

-(void)hidePresentMenu
{
    [UIView animateWithDuration:0.25f animations:^{
        _presentView.closeBtn.transform = CGAffineTransformMakeRotation(M_PI);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.25f animations:^{
            [_presentView setFrame:CGRectMake(0, SCREEN_HEIGTH, SCREEN_WIDTH, SCREEN_HEIGTH)];
            _presentView.hidden = YES;
        } completion:^(BOOL finished) {
            
        }];
    }];
}


-(void)setUpGridMenu
{
    NSArray *menuNameArray = SELECT_ARRAY;
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < menuNameArray.count; i++) {
        NSString *imageName = [NSString stringWithFormat:@"lanmu%d",i+1];
        [array addObject:imageName];
    }
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [flowLayout setSectionInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    
    _gridMenu = [[GridMenu alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 180) collectionViewLayout:flowLayout];
    _gridMenu.backgroundColor = [UIColor whiteColor];
    _gridMenu.dataSource = _gridMenu;
    _gridMenu.delegate = _gridMenu;
    _gridMenu.gridMenuDelegate = self;
    [_gridMenu setUpMenuData:@{@"gridName":menuNameArray,@"gridImage":array}];
}

-(void)showMenu:(NSInteger)flag
{
    if (_dimView == nil) {
        _dimView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
        _dimView.backgroundColor = [UIColor colorWithRed:0. green:0. blue:0. alpha:0.3];
        [_dimView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideMenu)]];
        _dimView.alpha = 0;
        
        [UIView animateWithDuration:0.25 animations:^{
            _dimView.alpha = 1;
            
        }];
        [self.view addSubview:_dimView];
        if (flag == 1) {
            [self setUpGridMenu];
            [self.view insertSubview:_gridMenu aboveSubview:_dimView];
        }/*else if(flag == 2){
            [self setUpPresentTable];
            [self.view insertSubview:_closeBtn aboveSubview:_dimView];
            [self.view insertSubview:_presentTable aboveSubview:_dimView];
        }*/
    }
}

-(void)dismissMenu:(NSInteger)flag
{
    [UIView animateWithDuration:0.25 animations:^{
        self.view.backgroundColor = [UIColor whiteColor];
        _dimView.alpha = 0;
        if (flag == 1) {
            _gridMenu.alpha = 0;
        }/*else if(flag == 2){
            _closeBtn.alpha = 0;
            _presentTable.alpha = 0;
        }*/
    } completion:^(BOOL finished) {
        if (flag == 1) {
            [_gridMenu removeFromSuperview];
            _gridMenu = nil;
        }/*else if(flag == 2){
            [_closeBtn removeFromSuperview];
            _closeBtn = nil;
            [_presentTable removeFromSuperview];
            _presentTable = nil;
        }*/
        [_dimView removeFromSuperview];
        _dimView = nil;
        _openView = 0;
    }];
}

-(void)inviteFriend
{
    [_info isLoginWithPresent:^(BOOL flag) {
        InviteVC *inviteVC = [[InviteVC alloc] init];
        inviteVC.leftTitle = @"邀请好友";
        [self.navigationController pushViewController:inviteVC animated:YES];
    } WithType:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark -- GridMenuDeleage
-(void)selectItem:(MenuCell *)cell
{
    [self hideMenu];
    
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [flowLayout setSectionInset:UIEdgeInsetsMake(10, 10, 0, 10)];
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 10.0;
    
    GoodsViewVC *goodsViewVC = [[GoodsViewVC alloc] initWithCollectionViewLayout:flowLayout];
    goodsViewVC.queryType = cell.tag;
    goodsViewVC.leftTitle = cell.menuLabel.text;
    [self.navigationController pushViewController:goodsViewVC animated:YES];
}

#pragma mark -- TapActionViewDelegate
-(void)tapViewAction:(UIView *)tapView
{
    switch (tapView.tag) {
        case 1000:
            //淘宝返利
            [self pushRebateHome];
            break;
        case 1001:
            //足迹
            [self pushFootPrints];
            break;
        case 1002:
            //聚优惠
            [self pushPolyHome];
            break;
        case 1003:
            //返利购
            [self pushReturnHome];
            break;
        case 1004:
            //兑换中心
            [self pushExChangeCenter];
            break;
        case 1005:
            //商城
            [self pushHotShop];
            break;
        case 1006:
            //我的
            [self pushPersonCenter:nil];
            break;
        default:
            break;
    }
}


#pragma mark -- push view fuction
-(void)pushRebateHome
{
    [_info isLoginWithPresent:^(BOOL flag) {
        if (!flag) {
            [[BMAlert sharedBMAlert] alert:@"登陆后去购物才有返利拿哦" cancleTitle:@"登陆" otherTitle:@"跳过" cancle:^(DoAlertView *alertView) {
                [_info presentNav:self WithCompletion:nil];
            } other:^(DoAlertView *alertView) {
                [self pushToTaoWeb];
            }];
        }else{
            [self pushToTaoWeb];
        }
    } WithType:NO];
}

-(void)pushToTaoWeb
{
    RebateHomeVC *rebateHomeVC = [[RebateHomeVC alloc] init];
    rebateHomeVC.leftTitle = @"购物";
    rebateHomeVC.isTrueTrance = YES;
    [self.navigationController pushViewController:rebateHomeVC animated:YES];
}

-(void)pushFootPrints
{
    [_info isLoginWithPresent:^(BOOL flag) {
        [_info saveTraceFlag:@"NO"];
        FootPrintsVC *footPrintsVC = [[FootPrintsVC alloc] init];
        footPrintsVC.leftTitle = @"足迹";
        [self.navigationController pushViewController:footPrintsVC animated:YES];
    } WithType:YES];
}

-(void)pushPolyHome
{
    PolyScrollVC *polyScrollVC = [[PolyScrollVC alloc] init];
    polyScrollVC.leftTitle = @"特价专享";
    [self.navigationController pushViewController:polyScrollVC animated:YES];
}

-(void)pushReturnHome
{
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [flowLayout setSectionInset:UIEdgeInsetsMake(10, 10, 0, 10)];
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 10.0;
    [flowLayout setHeaderReferenceSize:CGSizeMake(320, 180)];
    
    ReturnHomeVC *returnHomeVC =[[ReturnHomeVC alloc] initWithCollectionViewLayout:flowLayout];
    returnHomeVC.leftTitle = @"返利购";
    [self.navigationController pushViewController:returnHomeVC animated:YES];
}

-(void)pushHotShop
{
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [flowLayout setSectionInset:UIEdgeInsetsMake(5, 5, 0, 5)];
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 5.0;
    
    HotShopVC *hotShopVC =[[HotShopVC alloc] initWithCollectionViewLayout:flowLayout];
    hotShopVC.leftTitle = @"商城";
    [self.navigationController pushViewController:hotShopVC animated:YES];
}

-(void)pushExChangeCenter
{
    [_info isLoginWithPresent:^(BOOL flag) {
        ExChangeScrollVC *exChangeScrollVC = [[ExChangeScrollVC alloc] init];
        exChangeScrollVC.leftTitle = @"兑换中心";
        [self.navigationController pushViewController:exChangeScrollVC animated:YES];
    } WithType:YES];
}

-(void)pushPersonCenter:(NSNotification *)notification
{
    PersonCenterVC *personVC = [[PersonCenterVC alloc] init];
    personVC.leftTitle = @"会员中心";
    if (notification) {
        [self.navigationController popToRootViewControllerAnimated:NO];
        NSString *recviceStr = (NSString *)notification.object;
        if ([recviceStr isEqualToString:@"RegistFinish"]) {
            personVC.isRegistFinish = YES;
        }
        [self.navigationController pushViewController:personVC animated:NO];
    }else{
        [self.navigationController pushViewController:personVC animated:YES];
    }
    
}

-(void)pushNotificationView:(NSNotification *)notification
{
    if (notification) {
        if ([notification.object isKindOfClass:[NSDictionary class]]) {
            NSDictionary *remoteDic = (NSDictionary *)notification.object;
            if ([[remoteDic objectForKey:@"url"] length] > 0) {
                NotificationWebVC *notificationWebVC = [[NotificationWebVC alloc] init];
                notificationWebVC.leftTitle = [remoteDic objectForKey:@"from"];
                notificationWebVC.remoteDic = remoteDic;
                [self.navigationController pushViewController:notificationWebVC animated:YES];
            }
        }
    }
}

-(void)pushHomeTipView:(NSNotification *)notification
{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"homeTip"]) {
        [self initHoledView];
    }
}

@end
