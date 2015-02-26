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

#import "PersonInfo.h"
#import "BaseConnect.h"
#import "MongoConnect.h"

#import "MongoListModel.h"

static NSString *  collectionCellID=@"GoodsCell";
@interface GoodsViewVC ()<UICollectionViewDataSource,UICollectionViewDelegate,MutableMenuDelegate>
{
    BaseMutableMenu *_menu;
    NSMutableArray *_data;
    MongoListModel *_mongoListModel;
    
    NSInteger _category;
    NSInteger _pageNum;
}

@end

@implementation GoodsViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _data = [NSMutableArray array];
    _category = _queryType;
    _pageNum = 1;
    [self setUpNavBtn];
    [self setUpCollection];
    
    [self loadDataWith:_category andPage:_pageNum];
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
    if (!_menu) {
        _menu = [[BaseMutableMenu alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
        _menu.delegate = self;
        [_menu initScrollViewWithDirectionType:1];
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

-(void)loadDataWith:(NSInteger)category andPage:(NSInteger)page
{
    [self showHUD:DATA_LOAD];
    PersonInfo *person = [PersonInfo sharedPersonInfo];
    [[MongoConnect sharedMongoConnect] getMongoGoodsById:person.userId withCategory:category andPage:page success:^(id json) {
        [self hideAllHUD];
        NSDictionary *dic = (NSDictionary *)json;
        if ([BaseConnect isSucceeded:dic]) {
            _mongoListModel = [[MongoListModel alloc] initWithDictionary:dic error:nil];
            if (page == 1) {
                [_data removeAllObjects];
            }
            [_data addObjectsFromArray:_mongoListModel.data];
            [self.collectionView reloadData];
        }
    } failure:^(NSError *err) {
        [self hideAllHUD];
    }];
}

-(void)refresh
{
    [self loadDataWith:0 andPage:1];
    [super refresh];
}

-(void)moreFresh
{
    _pageNum ++;
    [self loadDataWith:_category andPage:_pageNum];
    [super moreFresh];
}

#pragma mark -- BaseMutableMenuDelegate
- (void)popoverViewDidDismiss:(BaseMutableMenu *)mutableMenu
{
    [_menu removeFromSuperview];
    _menu = nil;
}

-(void)clickAction:(MutableButton *)button
{
    [_menu hideView];
    [self loadDataWith:button.tag andPage:1];
}

#pragma mark -- UICollectionDelegate && UICollectionDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _data.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(VIEW_WIDTH/2 - 10, 250);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GoodsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCellID forIndexPath:indexPath];
    cell.tag = indexPath.row;
    [cell loadCell:_data[indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ReturnHomeGoodsVC *returnHomeGoodsVC = [[ReturnHomeGoodsVC alloc] init];
    returnHomeGoodsVC.leftTitle = @"商品详情";
    [self.navigationController pushViewController:returnHomeGoodsVC animated:YES];
}

@end
