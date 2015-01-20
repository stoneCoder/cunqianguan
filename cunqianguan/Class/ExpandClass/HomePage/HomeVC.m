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
    [self initNavBar];
    [self initAdView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self initActionView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initNavBar
{
    //设置navigationbar的颜色
    [self.navigationController.navigationBar setBarTintColor:UIColorFromRGB(0x4DD8CB)];
    //设置navigationbar左边按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(showMenu)];
    //设置navigationbar右边按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:Nil];
    //设置导航栏内容
    [self setTitleText:@"保鲜期"];
}

-(void)initAdView
{
    _adView = [[AdvertiseView alloc] initWithFrame:CGRectMake(0, 64, VIEW_WIDTH, SCREEN_HEIGTH - 384)];
    _adView.layer.borderWidth = 1;
    _adView.layer.borderColor = [UIColor yellowColor].CGColor;
    [self.view addSubview:_adView];
}

-(void)initActionView
{
    CGFloat visiableY =  64 + _adView.frame.size.height;
    _actionView = [TapActionView init];
    [_actionView setFrame:CGRectMake(0, visiableY, VIEW_WIDTH, SCREEN_HEIGTH - visiableY)];
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
    
    _gridMenu = [[GridMenu alloc] initWithFrame:CGRectMake(0, 64, VIEW_WIDTH, 160) collectionViewLayout:flowLayout];
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
    NSLog(@"%ld----------->%@",(long)cell.tag,cell.menuLabel.text);
}
@end
