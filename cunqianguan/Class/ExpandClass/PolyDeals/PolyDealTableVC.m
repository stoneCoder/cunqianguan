//
//  PolyDealTableVC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/4/10.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "PolyDealTableVC.h"
#import "PolyGoodsTableCell.h"
#import "HotDetailShopVC.h"

#import "Constants.h"
#import "PersonInfo.h"
#import "JYHConnect.h"
#import "FootConnect.h"
#import "BaseConnect.h"
#import "TeJiaListModel.h"

@interface PolyDealTableVC ()
{
    PersonInfo *_info;
    NSMutableArray *_data;
    NSInteger _pageNum;
    NSInteger _category;
    BOOL _firstLoad;
}
@end

static NSString *polyGoodsTableCellID = @"PolyGoodsTableCell";
@implementation PolyDealTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _info = [PersonInfo sharedPersonInfo];
    _data = [NSMutableArray array];
    _pageNum = 1;
    _category = 0;
    [self setUpTableView];
}

- (void)viewDidCurrentView:(NSInteger)index
{
    _category = index;
    if (!_firstLoad) {
        [self showLoaderView:self.tableView];
        [self loadDataWith:_category andPage:1];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUpTableView
{
    [self createTableWithStye:UITableViewStylePlain];
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGTH - 108);
    UINib *cellNib = [UINib nibWithNibName:@"PolyGoodsTableCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:polyGoodsTableCellID];
    self.tableView.backgroundColor = UIColorFromRGB(0xececec);
    self.tableView.separatorColor = UIColorFromRGB(0xe6e6e6);
    [self setRefreshEnabled:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)loadDataWith:(NSInteger)category andPage:(NSInteger)page
{
    [[JYHConnect sharedJYHConnect] getTeJiaGoodsById:_info.userId withCategory:category andPage:page success:^(id json) {
        [self hideLoaderView];
        NSDictionary *dic = (NSDictionary *)json;
        if ([BaseConnect isSucceeded:dic]) {
            TeJiaListModel *listModel = [[TeJiaListModel alloc] initWithDictionary:dic error:nil];
            if (page == 1) {
                [_data removeAllObjects];
            }
            [_data addObjectsFromArray:listModel.data];
            _firstLoad = YES;
            [self.tableView reloadData];
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

#pragma mark -- UITableViewDataSource && UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static PolyGoodsTableCell *cell = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        cell = [self.tableView dequeueReusableCellWithIdentifier:polyGoodsTableCellID];
    });
    
    if (_data.count > 0) {
        [cell loadData:_data[indexPath.row]];
    }
    
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    
    cell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.bounds), CGRectGetHeight(cell.bounds));
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    
    CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    height += 1;
    return height;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PolyGoodsTableCell *cell = [tableView dequeueReusableCellWithIdentifier:polyGoodsTableCellID forIndexPath:indexPath];
    [cell loadData:_data[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_info isLoginWithPresent:^(BOOL flag) {
        __block TeJiaModel *model = _data[indexPath.row];
        [[JYHConnect sharedJYHConnect] getTaoLinkById:_info.userId withGoodKey:model.numId success:^(id json) {
            NSDictionary *dic = (NSDictionary *)json;
            if ([BaseConnect isSucceeded:dic]) {
                
                //[self addTrace:_info.userId WithProduct:model.numId];
                NSString *urlPath = [[dic objectForKey:@"data"] objectForKey:@"url"];
                HotDetailShopVC *hotDetailShopVC = [[HotDetailShopVC alloc] init];
                hotDetailShopVC.leftTitle = @"商品详情";
                hotDetailShopVC.urlPath = urlPath;
                hotDetailShopVC.isfixUrl = YES;
                hotDetailShopVC.isTrueTrance = YES;
                [self.navigationController pushViewController:hotDetailShopVC animated:YES];
            }
        } failure:^(NSError *err) {
            
        }];
    } WithType:YES];
}

#pragma mark -- Private 添加足迹
-(void)addTrace:(NSString *)userId WithProduct:(NSString *)productId
{
    //添加足迹
    [[FootConnect sharedFootConnect] addTrace:userId withGoodKey:productId success:^(id json) {
        NSDictionary *dic = (NSDictionary *)json;
        if ([BaseConnect isSucceeded:dic]) {
            //添加足迹成功
            [_info saveTraceFlag:@"YES"];
            [[NSNotificationCenter defaultCenter] postNotificationName:kWebUrlFinal object:nil];
        }
    } failure:^(NSError *err) {
        
    }];
}



@end
