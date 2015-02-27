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

#import "JYHConnect.h"
#import "BaseConnect.h"
#import "PersonInfo.h"
#import "JYHDetailModel.h"

#import "BaseUtil.h"
@interface PolyGoodsDetailVC ()
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

-(void)setUpTableView
{
    [self createTableWithStye:UITableViewStyleGrouped];
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGTH - 64);
    
    _headView = [PolyDetailHeaderView headerView];
    self.tableView.tableHeaderView = _headView;
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
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return [self mathCellHeigth] + 10;
    }else if (section == 1){
        return [self mathCollectionHeigth];
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        CGFloat heigth = [self mathCellHeigth];
        CGRect frame = [self.tableView rectForFooterInSection:section];
        frame.origin.y = 0;
        frame.size.height = heigth;
        UIView *view = [[UIView alloc] initWithFrame:frame];
        view.backgroundColor = [UIColor whiteColor];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, VIEW_WIDTH - 40, heigth)];
        label.font = [UIFont systemFontOfSize:15.0f];
        label.textColor = UIColorFromRGB(0xABABAB);
        label.numberOfLines = 0;
        label.lineBreakMode = NSLineBreakByCharWrapping;
        label.text = _detailModel.xiaob;
        [view addSubview:label];
        return view;
    }else if (section == 1){
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
        [_favoriteView setUpFavoriteData:_collectionArray];
        return _favoriteView;
    }
    return nil;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 200, 44)];
        label.font = [UIFont systemFontOfSize:17.0f];
        NSString *labelText = @"";
        if (indexPath.section == 0) {
           labelText  = @"小编语";
        }else if (indexPath.section == 1){
            labelText = @"大家正在抢";
        }
        label.text = labelText;
        [cell addSubview:label];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


@end
