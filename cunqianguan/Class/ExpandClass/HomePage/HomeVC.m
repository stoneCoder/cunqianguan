//
//  HomeVC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/19.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "HomeVC.h"
#import "AdvertiseView.h"
#import "TapActionView.h"
#import "MenuCell.h"
#import "GridMenu.h"
#import "LoginVC.h"
#import "BaseNC.h"

@interface HomeVC ()<GridMenuDeleage>
{
    TapActionView *_actionView;
    AdvertiseView *_adView;
    UIView *_dimView;
    GridMenu *_gridMenu;
}

@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self initNavBar];
    [self initAdView];
    [self initActionView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initNavBar
{
    //设置navigationbar左边按钮
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0,0,22,22)];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"left_menu"] forState:UIControlStateNormal];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"left_menu_hover"] forState:UIControlStateHighlighted];
    [leftButton addTarget:self action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBtnItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftBtnItem;
    //设置navigationbar右边按钮
    UIButton *rigthButton = [[UIButton alloc] initWithFrame:CGRectMake(0,0,22,22)];
    [rigthButton setBackgroundImage:[UIImage imageNamed:@"right_search"] forState:UIControlStateNormal];
    [rigthButton setBackgroundImage:[UIImage imageNamed:@"right_search_hover"] forState:UIControlStateHighlighted];
    [rigthButton addTarget:self action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc] initWithCustomView:rigthButton];
    self.navigationItem.rightBarButtonItem = rightBtnItem;
    //设置导航栏内容
    [self setTitleImage:[UIImage imageNamed:@"logo"]];
    //[self setTitleText:@"保鲜期"];
}

-(void)initAdView
{
    _adView = [[AdvertiseView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT - 320)];
    _adView.layer.borderWidth = 1;
    _adView.layer.borderColor = [UIColor yellowColor].CGColor;
    _adView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_adView];
}

-(void)initActionView
{
    CGFloat visiableY =   _adView.frame.size.height;
    _actionView = [TapActionView init];
    [_actionView setFrame:CGRectMake(0, visiableY, VIEW_WIDTH, VIEW_HEIGHT - visiableY)];
    [self.view addSubview:_actionView];
}

#pragma mark -- Private
-(void)setUpGridMenu
{
    NSArray *menuNameArray = @[@"全部",@"时尚女装",@"流行男装",@"母婴玩具",@"数码家电",@"家居家纺",@"美容护肤",@"美食茗茶"];
    NSArray *menuImageArray = @[@"全部",@"时尚女装",@"流行男装",@"母婴玩具",@"数码家电",@"家居家纺",@"美容护肤",@"美食茗茶"];
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [flowLayout setSectionInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    
    _gridMenu = [[GridMenu alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 160) collectionViewLayout:flowLayout];
    _gridMenu.backgroundColor = [UIColor whiteColor];
    _gridMenu.gridMenuDelegate = self;
    _gridMenu.dataSource = _gridMenu;
    _gridMenu.delegate = _gridMenu;
    [_gridMenu setUpMenuData:@{@"gridName":menuNameArray,@"gridImage":menuImageArray}];
}

-(void)showMenu
{
    if (_dimView == nil) {
        [self setUpGridMenu];
        _dimView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
        _dimView.backgroundColor = [UIColor colorWithRed:0. green:0. blue:0. alpha:0.3];
        [_dimView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissMenu)]];
        _dimView.alpha = 0;
        
        [UIView animateWithDuration:0.25 animations:^{
            _dimView.alpha = 1;
            
        }];
        [self.view addSubview:_dimView];
        [self.view insertSubview:_gridMenu aboveSubview:_dimView];
        
    }
}

-(void)dismissMenu
{
    [UIView animateWithDuration:0.25 animations:^{
        self.view.backgroundColor = [UIColor whiteColor];
        _dimView.alpha = 0;
        _gridMenu.alpha = 0;
    } completion:^(BOOL finished) {
        [_gridMenu removeFromSuperview];
        _gridMenu = nil;
        [_dimView removeFromSuperview];
        _dimView = nil;
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

#pragma mark -- GridMenuDelegate
-(void)selectItem:(MenuCell *)cell
{
    [self dismissMenu];
    NSLog(@"%ld----------->%@",(long)cell.tag,cell.menuLabel.text);
    LoginVC *loginVC = [[LoginVC alloc] initWithNibName:nil bundle:nil];
    BaseNC * nav = [[BaseNC alloc] initWithRootViewController:loginVC];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:nil];
}
@end
