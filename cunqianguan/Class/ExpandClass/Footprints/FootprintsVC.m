//
//  FootprintsVC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/23.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "FootPrintsVC.h"
#import "FootPrintsCell.h"

#import "FootConnect.h"
#import "PersonConnect.h"
#import "BaseConnect.h"
#import "PersonInfo.h"
#import "FootListModel.h"
@interface FootPrintsVC ()<SWTableViewCellDelegate>
{
    PersonInfo *_info;
    NSInteger _pageNum;
    NSMutableArray *_data;
}

@end
static NSString *CellID=@"FootPrintsCell";
@implementation FootPrintsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _pageNum = 1;
    _info = [PersonInfo sharedPersonInfo];
    _data = [NSMutableArray array];
    [self setUpNavbtn];
    [self setUpTableView];
    [self loadData:_pageNum];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUpNavbtn
{
    [self setRigthBarWithDic:@{@"images":@[@"refresh"],@"imageshover":@[@"refresh_hover"]}];
}

-(void)setUpTableView
{
    [self createTableWithStye:UITableViewStylePlain];
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGTH - 64);
    UINib *cellNib = [UINib nibWithNibName:@"FootPrintsCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:CellID];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = UIColorFromRGB(0xececec);
    //[self setRefreshEnabled:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)rightBtnClick:(UIButton *)btn
{
    [self loadData:1];
}

-(void)loadData:(NSInteger)page
{
    [self showHUD:DATA_LOAD];
    [[FootConnect sharedFootConnect] getTraceGoods:_info.userId withPage:page success:^(id json) {
        [self hideAllHUD];
        NSDictionary *dic = (NSDictionary *)json;
        if ([BaseConnect isSucceeded:dic]) {
            FootListModel *listModel = [[FootListModel alloc] initWithDictionary:dic error:nil];
            if(page == 1){
                [_data removeAllObjects];
            }
            [_data addObjectsFromArray:listModel.data];
            if (_data.count == 0) {
                self.defaultEmptyView.hidden = NO;
                self.defaultEmptyView.emptydetailInfoLabel.hidden = NO;
                self.defaultEmptyView.emptydetailInfoLabel.text = @"赶快去浏览商品吧";
                self.tableView.hidden = YES;
            }
            [self.tableView reloadData];
        }
    } failure:^(NSError *err) {
        [self hideAllHUD];
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

#pragma mark -- UITableViewDataSource && UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FootPrintsCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
    cell.rightUtilityButtons = [self cellRightButtons];
    cell.delegate = self;
    cell.containingTableView = tableView;
    [cell hideUtilityButtonsAnimated:NO];
    [cell setCellHeight:cell.frame.size.height];
    cell.tag = indexPath.row;
    [cell loadCell:_data[indexPath.row]];
    return cell;
}

/**
 *  Cell滑动按钮
 *
 *  @return NSArray
 */
- (NSArray *)cellRightButtons
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray array];
    [rightUtilityButtons sw_addUtilityButtonWithColor:UIColorFromRGB(0xcccccc) title:@"收藏"];
    [rightUtilityButtons sw_addUtilityButtonWithColor:UIColorFromRGB(0xff2222) title:@"删除"];
    
    return rightUtilityButtons;
}

#pragma mark - SWTableViewCell delegate
- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index{
    FootModel *model = _data[cell.tag];
    switch (index) {
        case 0:
            // 收藏
            [self addUserFavorite:model.goodkey];
            break;
        case 1:
            // 置顶
            [self deleteFootTrace:model.goodkey];
            break;
    }
}

-(void)deleteFootTrace:(NSString *)goodKey
{
    [self showHUD:ACTION_LOAD];
    [[FootConnect sharedFootConnect] delTrace:_info.userId withGoodKey:goodKey success:^(id json) {
        [self hideAllHUD];
        NSDictionary *dic = (NSDictionary *)json;
        if ([BaseConnect isSucceeded:dic]) {
            [self hideAllHUD];
            [self loadData:1];
        }
    } failure:^(NSError *err) {
        [self hideAllHUD];
    }];
}

-(void)addUserFavorite:(NSString *)goodKey
{
    [self showHUD:ACTION_LOAD];
    [[PersonConnect sharedPersonConnect] addUserFavorite:_info.userId withGoodKey:goodKey  success:^(id json) {
        [self hideAllHUD];
        NSDictionary *dic = (NSDictionary *)json;
        __block NSString *resultStr = [dic objectForKey:@"info"];
        if ([BaseConnect isSucceeded:dic]) {
            [_info getUserInfo:_info.username withPwd:_info.password success:^(id json) {
                NSDictionary *dic = (NSDictionary *)json;
                if ([BaseConnect isSucceeded:dic]) {
                    [self showStringHUD:resultStr second:1.5];
                    [self.tableView reloadData];
                }
            } failure:^(id json) {
                
            }];
        }else{
            [self showStringHUD:@"收藏失败，请重试" second:1.5];
            [self.tableView reloadData];

        }
    } failure:^(NSError *err) {
        [self hideAllHUD];
    }];
}

- (BOOL)swipeableTableViewCellShouldHideUtilityButtonsOnSwipe:(SWTableViewCell *)cell{
    return YES;
}

@end
