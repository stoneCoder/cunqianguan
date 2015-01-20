//
//  HomeVC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/19.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "HomeVC.h"
#import "BaseCollectionView.h"
#import "AdvertiseView.h"
#import "TapActionView.h"
#import "BaseCollectionView.h"
#import "MenuCell.h"

static NSString *  collectionCellID=@"MenuCell";
@interface HomeVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    TapActionView *_actionView;
    AdvertiseView *_adView;
    BaseCollectionView *_collectionView;
    UIView *_dimView;
    NSArray *_menuImageArray;
    NSArray *_menuNameArray;
}

@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initNavBar];
    [self initAdView];
    _menuNameArray = @[@"全部",@"时尚女装",@"流行男装",@"母婴玩具",@"数码家电",@"家居家纺",@"美容护肤",@"美食茗茶"];
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
-(void)showMenu
{
    if (_dimView == nil) {
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        [flowLayout setSectionInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        _collectionView = [[BaseCollectionView alloc] initWithFrame:CGRectMake(0, 64, VIEW_WIDTH, 160) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        UINib *cellNib=[UINib nibWithNibName:@"MenuCell" bundle:nil];
        [_collectionView registerNib:cellNib forCellWithReuseIdentifier:collectionCellID];
        
        _dimView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
        _dimView.backgroundColor = [UIColor colorWithRed:0. green:0. blue:0. alpha:0.3];
        [_dimView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissMenu)]];
        _dimView.alpha = 0;
        
        [UIView animateWithDuration:0.25 animations:^{
            _dimView.alpha = 1;
            
        }];
        [self.view addSubview:_dimView];
        [self.view insertSubview:_collectionView aboveSubview:_dimView];
        
    }
}

-(void)dismissMenu
{
    [UIView animateWithDuration:0.25 animations:^{
        self.view.backgroundColor = [UIColor whiteColor];
        _dimView.alpha = 0;
        _collectionView.alpha = 0;
    } completion:^(BOOL finished) {
        [_collectionView removeFromSuperview];
        _collectionView = nil;
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

#pragma mark -- UICollectionDelegate &&  UICollectionDataSource
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return 8;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(VIEW_WIDTH/4, 80);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MenuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCellID forIndexPath:indexPath];
    cell.menuLabel.text = _menuNameArray[indexPath.row];
    cell.menuImage.backgroundColor = [UIColor redColor];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MenuCell *cell = (MenuCell *)[collectionView cellForItemAtIndexPath:indexPath];
    NSLog(@"%ld----------->%@",(long)indexPath.row,cell.menuLabel.text);
    [self dismissMenu];
}

@end
