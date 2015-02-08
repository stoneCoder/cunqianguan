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
#import "PresentTableView.h"
#import "ReturnHomeVC.h"
#import "RebateHomeVC.h"
#import "PolyDealVC.h"
#import "FootPrintsVC.h"
#import "ExChangeCenterVC.h"
#import "PersonCenterVC.h"

#import "BaseMutableMenu.h"
#import "GoodsViewVC.h"
#import "PolyScrollVC.h"
#import "ExChangeScrollVC.h"

#import "LoginVC.h"
#import "BaseNC.h"

@interface HomeVC ()<TapActionViewDelegate,GridMenuDeleage>
{
    TapActionView *_actionView;
    UIView *_dimView;
    GridMenu *_gridMenu;
    SMPageControl *_pageControl;
    PresentTableView *_presentTable;
    UIButton *_closeBtn;
    NSInteger _openView;
}

@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self hideReturnBtn];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self initNavBar];
    [self initAdView];
    [self initActionView];
    if (_dimView) {
        [_dimView removeFromSuperview];
        _dimView = nil;
        _openView = 0;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initNavBar
{
    [self setLeftBtnWithImage:@{@"nomarl":@"left_menu",@"highlight":@"left_menu_hover"}];
    //设置navigationbar右边按钮
    UIButton *rigthButton = [[UIButton alloc] initWithFrame:CGRectMake(0,0,22,22)];
    [rigthButton setBackgroundImage:[UIImage imageNamed:@"right_search"] forState:UIControlStateNormal];
    [rigthButton setBackgroundImage:[UIImage imageNamed:@"right_search_hover"] forState:UIControlStateHighlighted];
    [rigthButton addTarget:self action:@selector(test:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc] initWithCustomView:rigthButton];
    self.navigationItem.rightBarButtonItem = rightBtnItem;
    
    //设置导航栏内容
    [self setTitleImage:[UIImage imageNamed:@"logo"]];
}

-(void)initAdView
{
    _pageControl = [[SMPageControl alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, VIEW_HEIGHT - SCREEN_WIDTH)];
    
    AdvertisingView *adView = [[AdvertisingView alloc] initWithFrame:CGRectZero];
    adView.imageView.image = [UIImage imageNamed:@"banner"];
    [_pageControl insertBannerPages:adView];
    
    adView = [[AdvertisingView alloc] initWithFrame:CGRectZero];
    adView.imageView.image = [UIImage imageNamed:@"banner1"];
    [_pageControl insertBannerPages:adView];
    
    adView = [[AdvertisingView alloc] initWithFrame:CGRectZero];
    adView.imageView.image = [UIImage imageNamed:@"banner2"];
    [adView addTarget:self action:@selector(presentHelpView) forControlEvents:UIControlEventTouchUpInside];
    [_pageControl insertBannerPages:adView];
    
    [self.view addSubview:_pageControl];
}

-(void)initActionView
{
    CGFloat visiableY =   _pageControl.frame.size.height;
    _actionView = [TapActionView init];
    [_actionView setFrame:CGRectMake(0, visiableY, SCREEN_WIDTH, SCREEN_WIDTH)];
    _actionView.delegate = self;
    [self.view addSubview:_actionView];
}

#pragma mark -- Private
- (void)test:(id)sender
{
    LoginVC *loginVC = [[LoginVC alloc] init];
    BaseNC *nav = [[BaseNC alloc] initWithRootViewController:loginVC];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:nil];
}

- (void)leftBtnClicked:(id)sender
{
    _openView = 1;
    [self showMenu:_openView];
}

-(void)presentHelpView
{
    _openView = 2;
    [self showMenu:_openView];
}

-(void)hideMenu
{
    [self dismissMenu:_openView];
}

-(void)setUpGridMenu
{
    NSArray *menuNameArray = @[@"全部",@"时尚女装",@"流行男装",@"母婴玩具",@"数码家电",@"家居家纺",@"美容护肤",@"美食茗茶"];
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
    
    _gridMenu = [[GridMenu alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 160) collectionViewLayout:flowLayout];
    _gridMenu.backgroundColor = [UIColor whiteColor];
    _gridMenu.dataSource = _gridMenu;
    _gridMenu.delegate = _gridMenu;
    _gridMenu.gridMenuDelegate = self;
    [_gridMenu setUpMenuData:@{@"gridName":menuNameArray,@"gridImage":array}];
}

-(void)setUpPresentTable
{
    CGFloat visiableY = _pageControl.frame.size.height;
    _presentTable = [[PresentTableView alloc] initWithFrame:CGRectMake(0, visiableY, VIEW_WIDTH, VIEW_HEIGHT - visiableY) style:UITableViewStyleGrouped];
    _presentTable.backgroundColor = UIColorFromRGB(0xECECEC);
    _presentTable.scrollEnabled = NO;
    _presentTable.delegate = _presentTable;
    _presentTable.dataSource = _presentTable;
    
    _closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 45, 45)];
    [_closeBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    _closeBtn.center = ccp(VIEW_WIDTH/2,visiableY - 40);
    [_closeBtn addTarget:self action:@selector(hideMenu) forControlEvents:UIControlEventTouchUpInside];
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
        }else if(flag == 2){
            [self setUpPresentTable];
            [self.view insertSubview:_closeBtn aboveSubview:_dimView];
            [self.view insertSubview:_presentTable aboveSubview:_dimView];
        }
    }
}

-(void)dismissMenu:(NSInteger)flag
{
    [UIView animateWithDuration:0.25 animations:^{
        self.view.backgroundColor = [UIColor whiteColor];
        _dimView.alpha = 0;
        if (flag == 1) {
            _gridMenu.alpha = 0;
        }else if(flag == 2){
            _closeBtn.alpha = 0;
            _presentTable.alpha = 0;
        }
    } completion:^(BOOL finished) {
        if (flag == 1) {
            [_gridMenu removeFromSuperview];
            _gridMenu = nil;
        }else if(flag == 2){
            [_closeBtn removeFromSuperview];
            _closeBtn = nil;
            [_presentTable removeFromSuperview];
            _presentTable = nil;
        }
        [_dimView removeFromSuperview];
        _dimView = nil;
        _openView = 0;
    }];
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
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [flowLayout setSectionInset:UIEdgeInsetsMake(10, 5, 5, 5)];
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 10.0;
    
    GoodsViewVC *goodsViewVC = [[GoodsViewVC alloc] initWithCollectionViewLayout:flowLayout];
    goodsViewVC.leftTitle = cell.menuLabel.text;
    [self.navigationController pushViewController:goodsViewVC animated:YES];
}

#pragma mark -- TapActionViewDelegate
-(void)tapViewAction:(UIView *)tapView
{
    switch (tapView.tag) {
        case 1000:
            //淘宝返利
            tapView.backgroundColor = UIColorFromRGB(0xed961a);
            [self pushRebateHome];
            break;
        case 1001:
            //足迹
            tapView.backgroundColor = UIColorFromRGB(0x10b5cd);
            [self pushFootPrints];
            break;
        case 1002:
            //聚优惠
            tapView.backgroundColor = UIColorFromRGB(0xe83434);
            [self pushPolyHome];
            break;
        case 1003:
            //返利购
            tapView.backgroundColor = UIColorFromRGB(0x12c2b3);
            [self pushReturnHome];
            break;
        case 1004:
            //兑换中心
            tapView.backgroundColor = UIColorFromRGB(0x38c470);
            [self pushExChangeCenter];
            break;
        case 1005:
            //商城
            tapView.backgroundColor = UIColorFromRGB(0x33a5c2);
            break;
        case 1006:
            //我的
            tapView.backgroundColor = UIColorFromRGB(0x5f8bcd);
            [self pushPersonCenter];
            break;
        default:
            break;
    }
}


#pragma mark -- push view fuction
-(void)pushRebateHome
{
    RebateHomeVC *rebateHomeVC = [[RebateHomeVC alloc] init];
    [self.navigationController pushViewController:rebateHomeVC animated:YES];
}

-(void)pushFootPrints
{
    FootPrintsVC *footPrintsVC = [[FootPrintsVC alloc] init];
    footPrintsVC.leftTitle = @"足迹";
    [self.navigationController pushViewController:footPrintsVC animated:YES];
}

-(void)pushPolyHome
{
    PolyScrollVC *polyScrollVC = [[PolyScrollVC alloc] init];
    polyScrollVC.leftTitle = @"聚优惠";
    [self.navigationController pushViewController:polyScrollVC animated:YES];
}

-(void)pushReturnHome
{
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [flowLayout setSectionInset:UIEdgeInsetsMake(10, 5, 5, 5)];
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 10.0;
    [flowLayout setHeaderReferenceSize:CGSizeMake(320, 180)];
    
    ReturnHomeVC *returnHomeVC =[[ReturnHomeVC alloc] initWithCollectionViewLayout:flowLayout];
    returnHomeVC.leftTitle = @"返利购";
    [self.navigationController pushViewController:returnHomeVC animated:YES];
}

-(void)pushExChangeCenter
{
    ExChangeScrollVC *exChangeScrollVC = [[ExChangeScrollVC alloc] init];
    exChangeScrollVC.leftTitle = @"兑换中心";
    [self.navigationController pushViewController:exChangeScrollVC animated:YES];
}

-(void)pushPersonCenter
{
    PersonCenterVC *personVC = [[PersonCenterVC alloc] init];
    personVC.leftTitle = @"会员中心";
    [self.navigationController pushViewController:personVC animated:YES];
}

@end
