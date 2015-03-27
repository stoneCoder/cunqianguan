//
//  PolyGoodsDetailVC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/2/11.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "PolyGoodsDetailVC.h"
#import "PolyDetailHeaderView.h"
#import "FavoriteView.h"
#import "ReturnHomeGoodsVC.h"
#import "PolyGoodsRootVC.h"

#import "JYHConnect.h"
#import "BaseConnect.h"
#import "PersonInfo.h"
#import "JYHDetailModel.h"

#import "BaseUtil.h"
@interface PolyGoodsDetailVC ()<FavoriteViewDelegate>
{
    FavoriteView *_favoriteView;
    PolyDetailHeaderView *_headView;
    
    NSMutableArray *_collectionArray;
    JYHDetailModel *_detailModel;
}


@end

@implementation PolyGoodsDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _collectionArray = [NSMutableArray array];
    [self setUpTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    //[self.tableView reloadData];
}

-(void)setUpTableView
{
    [self createTableWithStye:UITableViewStylePlain];
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGTH - 124);
    
    _headView = [PolyDetailHeaderView headerView];
    self.tableView.tableHeaderView = _headView;
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

-(void)reloadView:(JYHDetailModel *)model
{
    _detailModel = model;
    [_collectionArray addObjectsFromArray:_detailModel.rec];
    [_headView loadData:_detailModel];
    [self.tableView reloadData];
}


#pragma mark -- Private
-(CGFloat)mathCellHeigth
{
    return [BaseUtil getHeightByString:_detailModel.xiaob font:[UIFont systemFontOfSize:15.0f] allwidth:VIEW_WIDTH - 40];
}

-(CGFloat)mathCollectionHeigth
{
    CGFloat height = 120;
    NSInteger count = _collectionArray.count;
    if (count%3 > 1) {
        height = 120*(count/3 + count%3) + 10;
    }else{
        height = 120*count/3 + 10;
    }
    return height;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark -- UITableViewDataSource && UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            if (indexPath.row == 0) {
                return 44.0f;
            }else{
                return [self mathCellHeigth] + 10;
            }
            break;
        case 1:
            if (indexPath.row == 0) {
                return 44.0f;
            }else{
                return [self mathCollectionHeigth];
            }
            break;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    bgView.backgroundColor = UIColorFromRGB(0xececec);
    return bgView;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    if (section == 0) {
//        return [self mathCellHeigth] + 10;
//    }else if (section == 1){
//        return [self mathCollectionHeigth];
//    }
//    return 0;
//}

//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    if (section == 0) {
//        CGFloat heigth = [self mathCellHeigth];
//        CGRect frame = [self.tableView rectForFooterInSection:section];
//        frame.origin.y = 0;
//        frame.size.height = heigth;
//        UIView *view = [[UIView alloc] initWithFrame:frame];
//        view.backgroundColor = [UIColor whiteColor];
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, VIEW_WIDTH - 40, heigth)];
//        label.backgroundColor = [UIColor clearColor];
//        label.font = [UIFont systemFontOfSize:15.0f];
//        label.textColor = UIColorFromRGB(0xABABAB);
//        label.numberOfLines = 0;
//        label.lineBreakMode = NSLineBreakByCharWrapping;
//        label.text = _detailModel.xiaob;
//        [view addSubview:label];
//        return view;
//    }else if (section == 1){
//        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
//        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
//        [flowLayout setSectionInset:UIEdgeInsetsMake(10, 5, 5, 5)];
//        flowLayout.minimumInteritemSpacing = 0;
//        flowLayout.minimumLineSpacing = 0;
//        
//        CGFloat heigth = [self mathCollectionHeigth];
//        _favoriteView = [[FavoriteView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, heigth) collectionViewLayout:flowLayout];
//        _favoriteView.backgroundColor = [UIColor whiteColor];
//        _favoriteView.dataSource = _favoriteView;
//        _favoriteView.delegate = _favoriteView;
//        _favoriteView.favoriteViewDelegate = self;
//        [_favoriteView setUpFavoriteData:_collectionArray];
//        return _favoriteView;
//    }
//    return nil;
//}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    switch (indexPath.section) {
        case 0:
            if (indexPath.row == 0) {
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 200, 44)];
                label.backgroundColor = [UIColor clearColor];
                label.font = [UIFont systemFontOfSize:17.0f];
                label.text = @"小编语";
                [cell addSubview:label];
            }else if (indexPath.row == 1){
                [cell addSubview:[self createEditorView]];
            }
            break;
        case 1:
            if (indexPath.row == 0) {
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 200, 44)];
                label.backgroundColor = [UIColor clearColor];
                label.font = [UIFont systemFontOfSize:17.0f];
                label.text = @"大家正在抢";
                [cell addSubview:label];
            }else if (indexPath.row == 1){
                [cell addSubview:[self createCollectionView]];
            }
            break;
    }

    if (!iOS7) {
        UIView *bgView =  [[UIView alloc] initWithFrame:cell.frame];
        bgView.backgroundColor = [UIColor whiteColor];
        cell.backgroundView = nil;
        cell.backgroundView = bgView;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark -- Private
-(UIView *)createEditorView
{
    CGFloat heigth = [self mathCellHeigth];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, heigth)];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, VIEW_WIDTH - 40, heigth)];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:15.0f];
    label.textColor = UIColorFromRGB(0xABABAB);
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByCharWrapping;
    label.text = _detailModel.xiaob;
    [view addSubview:label];
    return view;
}

-(UIView *)createCollectionView
{
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [flowLayout setSectionInset:UIEdgeInsetsMake(10, 5, 5, 5)];
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    
    CGFloat heigth = [self mathCollectionHeigth];
    _favoriteView = [[FavoriteView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, heigth) collectionViewLayout:flowLayout];
    _favoriteView.backgroundColor = [UIColor whiteColor];
    _favoriteView.dataSource = _favoriteView;
    _favoriteView.delegate = _favoriteView;
    _favoriteView.favoriteViewDelegate = self;
    [_favoriteView setUpFavoriteData:_collectionArray];
    return _favoriteView;
}

#pragma mark -- FavoriteViewDelegate
-(void)clickItemCell:(JYHItemModel *)model
{
    PolyGoodsRootVC *polyGoodsRootVC = [[PolyGoodsRootVC alloc] init];
    NSString *goodkey = [NSString stringWithFormat:@"1000_%@",model.productId];
    polyGoodsRootVC.goodKey = goodkey;
    polyGoodsRootVC.leftTitle = @"商品详情";
    [self.navigationController pushViewController:polyGoodsRootVC animated:YES];
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
