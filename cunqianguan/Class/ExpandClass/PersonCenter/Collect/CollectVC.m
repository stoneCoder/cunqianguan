//
//  CollectVC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/31.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "CollectVC.h"
#import "CollectCell.h"
#import "AllCheckView.h"
#import "UICollectionViewCell+AutoLayoutDynamicHeightCalculation.h"
#import "ReturnHomeGoodsVC.h"
#import "HotDetailShopVC.h"

#import "PersonConnect.h"
#import "BaseConnect.h"
#import "PersonInfo.h"
#import "CollectListModel.h"
#import "UIBarButtonItem+Badge.h"
@interface CollectVC ()<AllCheckViewDelegate,CheckmarkViewDelegate>
{
    NSInteger _pageNum;
    NSMutableArray *_data;
    PersonInfo *_info;
    AllCheckView *_checkView;
    BOOL _isAllCheck;
    BOOL _isEditModel;
    NSMutableArray *_checkArray;
}

@end
static NSString *collectID = @"CollectCell";
@implementation CollectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _pageNum = 1;
    _isAllCheck = NO;
    _isEditModel = NO;
    _data = [NSMutableArray array];
    _checkArray = [NSMutableArray array];
    _info = [PersonInfo sharedPersonInfo];
    [self setUpNavBtn];
    [self setUpCollection];
    [self setUpBottom];
    [self showLoaderView:self.collectionView];
    [self loadData:_pageNum];
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
    [rigthButton setBackgroundImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
    [rigthButton setBackgroundImage:[UIImage imageNamed:@"delete_down"] forState:UIControlStateHighlighted];
    [rigthButton addTarget:self action:@selector(deleteModel:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc] initWithCustomView:rigthButton];
    self.navigationItem.rightBarButtonItem = rightBtnItem;
}

-(void)setUpCollection
{
    self.collectionView.backgroundColor = UIColorFromRGB(0xECECEC);
    UINib *cellNib = [UINib nibWithNibName:@"CollectCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:collectID];
    [self setRefreshEnabled:YES];
}

-(void)setUpBottom
{
    _checkView = [AllCheckView init];
    _checkView.hidden = YES;
    _checkView.delegate = self;
    _checkView.frame = CGRectMake(0, VIEW_HEIGHT - 100, SCREEN_WIDTH, 100);
    _checkView.layer.shadowOpacity = 0.1;
    [self.view insertSubview:_checkView aboveSubview:self.collectionView];
}

-(void)loadData:(NSInteger)page
{
    [[PersonConnect sharedPersonConnect] getUserFavorite:_info.email pwd:_info.password page:page success:^(id json) {
        [self hideLoaderView];
        NSDictionary *dic = (NSDictionary *)json;
        if ([BaseConnect isSucceeded:dic]) {
            CollectListModel *listModel = [[CollectListModel alloc] initWithDictionary:dic error:nil];
            if (page == 1) {
                [_data removeAllObjects];
            }
            [_data addObjectsFromArray:listModel.data];
            if (_data.count == 0) {
                self.defaultEmptyView.hidden = NO;
                self.collectionView.hidden = YES;
            }
            [self.collectionView reloadData];
        }
    } failure:^(NSError *err) {
        [self hideLoaderView];
    }];
}

-(void)refresh
{
    [self loadData:1];
    [super refresh];
}

-(void)moreFresh
{
    _pageNum ++;
    [self loadData:_pageNum];
    [super moreFresh];
}

-(void)deleteModel:(id)sender
{
    if (!_isEditModel) {
        _isEditModel = YES;
        _checkView.hidden = NO;
        [self.collectionView reloadData];
    }else{
        [self cancleAction];
    }
   
}

#pragma mark -- UICollectionDelegate && UICollectionDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _data.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGFloat width = (SCREEN_WIDTH - 30)/2;
    CollectCell *cell = [CollectCell heightCalculationCellFromNibWithName:NSStringFromClass([CollectCell class])];
    CGFloat height = [cell heightAfterAutoLayoutPassAndRenderingWithBlock:^{
        if (_data.count > 0) {
            [cell loadCell:_data[indexPath.row]];
        }
    }];
    return CGSizeMake(width, height);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectID forIndexPath:indexPath];
    cell.tag = indexPath.row;
    cell.checkmarkView.tag = indexPath.row;
    cell.checkmarkView.delegate = self;
    [cell loadCell:_data[indexPath.row]];
    if (_isEditModel) {
        cell.checkmarkView.hidden = NO;
        if (_isAllCheck) {
            [cell.checkmarkView check];
        }else{
            [cell.checkmarkView uncheck];
        }
    }else{
        cell.checkmarkView.hidden = YES;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (!_isEditModel) {
//        CollectModel *model = _data[indexPath.row];
//        NSString *urlPath = model.itemUrl;
//        HotDetailShopVC *hotDetailShopVC = [[HotDetailShopVC alloc] init];
//        hotDetailShopVC.leftTitle = @"商品详情";
//        hotDetailShopVC.urlPath = urlPath;
//        [self.navigationController pushViewController:hotDetailShopVC animated:YES];
        ReturnHomeGoodsVC *returnHomeGoodsVC = [[ReturnHomeGoodsVC alloc] init];
        CollectModel *model = _data[indexPath.row];
        returnHomeGoodsVC.goodKey = model.goodkey;
        returnHomeGoodsVC.leftTitle = @"商品详情";
        returnHomeGoodsVC.type = 1;
        [self.navigationController pushViewController:returnHomeGoodsVC animated:YES];
    }
}

#pragma mark --  CheckmarkViewDelegate
-(BOOL)checkmarkViewShouldCheck:(CheckmarkView*)checkmarkView
{
    return YES;
}

-(void)checkmarkViewDidCheck:(CheckmarkView*)checkmarkView
{
    CollectModel *model = _data[checkmarkView.tag];
    NSString *goodKey = model.goodkey;
    if (![_checkArray containsObject:goodKey]) {
        [_checkArray addObject:goodKey];
    }
}

-(void)checkmarkViewDidUncheck:(CheckmarkView*)checkmarkView
{
    CollectModel *model = _data[checkmarkView.tag];
    NSString *goodKey = model.goodkey;
    [_checkArray removeObject:goodKey];
}
#pragma mark -- AllCheckViewDelegate
-(void)allCheckAction
{
    if (_isAllCheck) {
        _isAllCheck = NO;
    }else{
        _isAllCheck = YES;
    }
    [self.collectionView reloadData];
}

-(void)cancleAction
{
    _isAllCheck = NO;
    _isEditModel = NO;
    _checkView.hidden = YES;
    [self.collectionView reloadData];
}

-(void)submitAction
{
    //NSLog(@"%@------------->",_checkArray);
    if (_checkArray.count == 0) {
        [self showStringHUD:@"请选择需删除选项" second:2];
    }else{
        [self showHUD:ACTION_LOAD];
        NSString *goodKeys = [_checkArray componentsJoinedByString:@","];
        [[PersonConnect sharedPersonConnect] delUserFavorite:_info.userId withGoodKey:goodKeys success:^(id json) {
            NSDictionary *dic = (NSDictionary *)json;
            if ([BaseConnect isSucceeded:dic]) {
                _isAllCheck = NO;
                _isEditModel = NO;
                _checkView.hidden = YES;
                _checkView.checkBtn.selected = NO;
                [self hideAllHUD];
                [self loadData:1];
                
//                [_info getUserInfo:_info.username withPwd:_info.password success:^(id json) {
//                    [self hideAllHUD];
//                    NSDictionary *dic = (NSDictionary *)json;
//                    if ([BaseConnect isSucceeded:dic]) {
//                        _isAllCheck = NO;
//                        _isEditModel = NO;
//                        _checkView.hidden = YES;
//                        _checkView.checkBtn.selected = NO;
//                        [self loadData:1];
//                    }
//                } failure:^(id json) {
//                    
//                }];
            }else{
                [self showStringHUD:[dic objectForKey:@"info"] second:1.5];
            }
        } failure:^(NSError *err) {
            [self hideAllHUD];
        }];
    }
    
}
@end
