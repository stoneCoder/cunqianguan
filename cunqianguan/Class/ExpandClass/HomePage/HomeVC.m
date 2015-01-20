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

@interface HomeVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    TapActionView *_actionView;
    AdvertiseView *_adView;
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
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:Nil];
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
    return 7;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    UILabel* label = (id)[cell viewWithTag:5];
    if(!label) label = [[UILabel alloc] initWithFrame:CGRectMake(50, 50, 20, 20)];
    label.tag = 5;
    label.textColor = [UIColor blackColor];
    label.text = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
    label.backgroundColor = [UIColor clearColor];
    [cell addSubview:label];
    
    return cell;
}

@end
