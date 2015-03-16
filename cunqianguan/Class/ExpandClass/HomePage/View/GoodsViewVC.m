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

#import "BaseUtil.h"
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
    NSArray *_selectId;
    
    NSInteger _category;
    NSInteger _parentId;
    NSInteger _pageNum;
    PersonInfo *_info;
}

@end

@implementation GoodsViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _info = [PersonInfo sharedPersonInfo];
    _data = [NSMutableArray array];
    _selectId = SELECT_ID;
    _category = _queryType;
    _parentId = _queryType;
    _pageNum = 1;
    [self setUpLeftBtn:self.leftTitle];
    [self setUpRightBtn];
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
-(void)setUpRightBtn
{
    [self setRigthBtnTitle:@"筛选" WithImage:@"shaixuan" andHighlightImage:@"shaixuan_down" edgeInsetsWithTitle:0];
}

-(void)setUpLeftBtn:(NSString *)aTitle
{
    NSString *defaultImageName = @"back";
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectZero];
    CGRect btnFrame;
    NSString * btnTitleStr = aTitle;
    if (btnTitleStr.length > 0) {
        btnTitleStr = [NSString stringWithFormat:@"%@",aTitle];
        float width = [BaseUtil getWidthByString:btnTitleStr font:button.titleLabel.font allheight:22 andMaxWidth:200];
        btnFrame = CGRectMake(0,0,width + 22,22);
    }else{
        btnFrame = CGRectMake(0,0,22,22);
    }
    [button setFrame:btnFrame];
    [button setImage:[UIImage imageNamed:defaultImageName] forState:UIControlStateNormal];
    [button setTitle:btnTitleStr forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:btnTitleStr forState:UIControlStateHighlighted];
    [button setTitleColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.5] forState:UIControlStateHighlighted];
    button.titleLabel.font=[UIFont boldSystemFontOfSize:17.0];
    
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    if (iOS7) {//iOS7 custom leftBarButtonItem 偏移
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -10;
        self.navigationItem.leftBarButtonItems = @[negativeSpacer, btnItem];
    }else{
        self.navigationItem.leftBarButtonItem = btnItem;
        
    }
    [button addTarget:self action:@selector(leftBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)leftBtnClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightBtnClick:(id)sender
{
    NSInteger index = [_selectId indexOfObject:[NSString stringWithFormat:@"%ld",(long)_parentId]];
    if (index > 0) {
        index = index - 1;
    }
    if (!_menu) {
        _menu = [[BaseMutableMenu alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
        _menu.delegate = self;
        [_menu initScrollViewWithDirectionType:1];
        [self.view addSubview:_menu];
        [_menu selectIndex:index];
        [_menu showView];
    }else{
        [_menu selectIndex:index];
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
    [self showLoaderView];
    _category = category;
    [[MongoConnect sharedMongoConnect] getMongoGoodsById:_info.userId withCategory:category andPage:page success:^(id json) {
        [self hideLoaderView];
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
        [self hideLoaderView];
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

#pragma mark -- BaseMutableMenuDelegate
- (void)popoverViewDidDismiss:(BaseMutableMenu *)mutableMenu
{
    //[_menu removeFromSuperview];
    //_menu = nil;
}

-(void)clickAction:(MutableButton *)button
{
    [_menu hideView];
    [self setUpLeftBtn:button.titleLabel.text];
    _parentId = button.parentId;
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
    [_info isLoginWithPresent:^(BOOL flag) {
        ReturnHomeGoodsVC *returnHomeGoodsVC = [[ReturnHomeGoodsVC alloc] init];
        MongoModel *model = _data[indexPath.row];
        returnHomeGoodsVC.goodKey = model.goodkey;
        returnHomeGoodsVC.leftTitle = @"商品详情";
        [self.navigationController pushViewController:returnHomeGoodsVC animated:YES];
    } WithType:YES];
}

@end
