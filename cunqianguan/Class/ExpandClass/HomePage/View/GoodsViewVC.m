//
//  GoodsViewVC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/2/3.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "GoodsViewVC.h"
#import "GoodsCell.h"
#import "ReturnHomeGoodsVC.h"
#import "BaseMutableMenu.h"

static NSString *  collectionCellID=@"GoodsCell";
@interface GoodsViewVC ()<UICollectionViewDataSource,UICollectionViewDelegate,MutableMenuDelegate>
{
    BaseMutableMenu *_menu;
}

@end

@implementation GoodsViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setUpNavBtn];
    [self setUpCollection];
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
    UIButton *rigthButton = [[UIButton alloc] initWithFrame:CGRectMake(0,0,22,22)];
    [rigthButton setBackgroundImage:[UIImage imageNamed:@"right_search"] forState:UIControlStateNormal];
    [rigthButton setBackgroundImage:[UIImage imageNamed:@"right_search_hover"] forState:UIControlStateHighlighted];
    [rigthButton addTarget:self action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc] initWithCustomView:rigthButton];
    self.navigationItem.rightBarButtonItem = rightBtnItem;
}

-(void)showMenu
{
    //NSArray *menuArr = @[@"全部", @"男装", @"女装", @"居家", @"测试5", @"测试6", @"测试7", @"测试8", @"测试9", @"测试10"];
    NSDictionary *menuDic = @{@"全部":@[@{@"呵呵":@[@"哇哈哈1",@"哇哈哈1",@"哇哈哈1",@"哇哈哈1",@"哇哈哈1",@"哇哈哈1",@"哇哈哈1",@"哇哈哈1",@"哇哈哈1",@"哇哈哈1",@"哇哈哈1",@"哇哈哈1",@"哇哈哈1",@"哇哈哈1",@"哇哈哈1",@"哇哈哈1",@"哇哈哈1"]},@{@"什么":@[@"哇哈哈2",@"哇哈哈2",@"哇哈哈2",@"哇哈哈2",@"哇哈哈2"]},@{@"什么1":@[@"哇哈哈2",@"哇哈哈2",@"哇哈哈2",@"哇哈哈2",@"哇哈哈2"]},@{@"什么2":@[@"哇哈哈2",@"哇哈哈2",@"哇哈哈2",@"哇哈哈2",@"哇哈哈2"]}],@"女装":@[@{@"嘿嘿":@[@"哇哈哈3",@"哇哈哈3",@"哇哈哈3",@"哇哈哈3",@"哇哈哈1",@"哇哈哈1",@"哇哈哈1",@"哇哈哈1",@"哇哈哈1",@"哇哈哈1",@"哇哈哈1",@"哇哈哈1",@"哇哈哈1",@"哇哈哈3",@"哇哈哈3",@"哇哈哈1",@"哇哈哈1"]},@{@"互殴":@[@"哇哈哈2",@"哇哈哈2",@"哇哈哈2",@"哇哈哈2",@"哇哈哈2"]},@{@"什么1":@[@"哇哈哈2",@"哇哈哈2",@"哇哈哈2",@"哇哈哈2",@"哇哈哈2"]},@{@"打算":@[@"哇哈哈2",@"哇哈哈2",@"哇哈哈2",@"哇哈哈2",@"哇哈哈2"]}]};
    if (!_menu) {
        _menu = [[BaseMutableMenu alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
        _menu.delegate = self;
        [_menu initScrollView:menuDic WithDirectionType:1];
        [self.view addSubview:_menu];
        [_menu showView];
    }
}

-(void)setUpCollection
{
    self.collectionView.backgroundColor = UIColorFromRGB(0xECECEC);
    UINib *cellNib=[UINib nibWithNibName:@"GoodsCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:collectionCellID];
    
    [self setRefreshEnabled:YES];
}

- (void)popoverViewDidDismiss:(BaseMutableMenu *)mutableMenu
{
    [_menu removeFromSuperview];
    _menu = nil;
}

#pragma mark -- UICollectionDelegate && UICollectionDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 16;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(VIEW_WIDTH/2 - 10, 250);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GoodsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCellID forIndexPath:indexPath];
    cell.tag = indexPath.row;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ReturnHomeGoodsVC *returnHomeGoodsVC = [[ReturnHomeGoodsVC alloc] init];
    returnHomeGoodsVC.leftTitle = @"商品详情";
    [self.navigationController pushViewController:returnHomeGoodsVC animated:YES];
}

@end
