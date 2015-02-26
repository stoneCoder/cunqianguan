//
//  PolyDealVC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/23.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "PolyDealVC.h"
#import "PolyGoodsCell.h"
#import "TouchPropagatedScrollView.h"
#import "BaseSegment.h"

#import "BaseSelectView.h"
#import "PolyGoodsRootVC.h"

#import "BaseConnect.h"
#import "JYHConnect.h"
#import "PersonInfo.h"

#import "JYHListModel.h"
#import "JYHModel.h"

@interface PolyDealVC ()
{
    NSMutableArray *_data;
    JYHListModel *_listModel;
    NSInteger _pageNum;
    NSInteger _category;
}

@end
static NSString *  collectionCellID=@"PolyGoodsCell";
@implementation PolyDealVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _data = [NSMutableArray array];
    _pageNum = 1;
    _category = 0;
    [self setUpCollection];
}

-(void)viewDidCurrentView:(NSInteger)index
{
    [_data removeAllObjects];
    _category = index;
    [self loadDataWith:_category andPage:1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

-(void)setUpNavBtn
{
    UIButton *rigthButton = [[UIButton alloc] initWithFrame:CGRectMake(0,0,22,22)];
    [rigthButton setBackgroundImage:[UIImage imageNamed:@"right_search"] forState:UIControlStateNormal];
    [rigthButton setBackgroundImage:[UIImage imageNamed:@"right_search_hover"] forState:UIControlStateHighlighted];
    //[rigthButton addTarget:self action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc] initWithCustomView:rigthButton];
    self.navigationItem.rightBarButtonItem = rightBtnItem;
}

-(void)setUpCollection
{
    self.collectionView.backgroundColor = UIColorFromRGB(0xECECEC);
    //[self.collectionView setFrame:CGRectMake(0, 0, VIEW_WIDTH, self.collectionView.frame.size.height)];
    UINib *cellNib = [UINib nibWithNibName:@"PolyGoodsCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:collectionCellID];
    [self setRefreshEnabled:YES];
}

-(void)loadDataWith:(NSInteger)category andPage:(NSInteger)page
{
    [self showHUD:DATA_LOAD];
    PersonInfo *person = [PersonInfo sharedPersonInfo];
    [[JYHConnect sharedJYHConnect] getJYHGoodsById:person.userId withCategory:category andPage:page success:^(id json) {
        [self hideAllHUD];
        NSDictionary *dic = (NSDictionary *)json;
        if ([BaseConnect isSucceeded:dic]) {
            _listModel = [[JYHListModel alloc] initWithDictionary:dic error:nil];
            if (page == 1) {
                [_data removeAllObjects];
            }
            [_data addObjectsFromArray:_listModel.data];
            [self.collectionView reloadData];
        }
    } failure:^(NSError *err) {
        [self hideAllHUD];
    }];
}

-(void)refresh
{
    [self loadDataWith:_category andPage:1];
    [super refresh];
}

-(void)moreFresh
{
    _pageNum ++;
    [self loadDataWith:_category andPage:_pageNum];
    [super moreFresh];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark -- UICollectionDelegate && UICollectionDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [_data count];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(VIEW_WIDTH/2 - 10, 250);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PolyGoodsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCellID forIndexPath:indexPath];
    [cell loadCell:_data[indexPath.row]];
    cell.tag = indexPath.row;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    PolyGoodsRootVC *polyGoodsRootVC = [[PolyGoodsRootVC alloc] init];
    polyGoodsRootVC.leftTitle = @"商品详情";
    [self.navigationController pushViewController:polyGoodsRootVC animated:YES];
}

@end
