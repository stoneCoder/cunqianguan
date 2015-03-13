//
//  AccountInfoVC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/28.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "RunningWaterVC.h"
#import "BaseSegment.h"
#import "RunningWaterCell.h"

#import "PersonConnect.h"
#import "BaseConnect.h"
#import "PersonInfo.h"

#import "RunningWaterListModel.h"

@interface RunningWaterVC ()<CCSegmentDelegate>
{
    BaseSegment *_segment;
    UIView *_headView;
    
    PersonInfo *_info;
    NSInteger _type; //0  收入  1 提现  2 带返利   3 兑换
    NSInteger _pageNum;
    RunningWaterListModel *_listModel;
    NSMutableArray *_data;
}

@end
static NSString *RunningWaterCellID = @"RunningWaterCell";
@implementation RunningWaterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _info = [PersonInfo sharedPersonInfo];
    _pageNum = 1;
    _data = [NSMutableArray array];
    [self setUpTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidCurrentView:(NSInteger)type
{
    _type = type;
    [self loadData:_type andPage:_pageNum];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)setUpTableView
{
    [self createTableWithStye:UITableViewStylePlain];
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGTH - 64);
    
    UINib *CellNib = [UINib nibWithNibName:@"RunningWaterCell" bundle:nil];
    [self.tableView registerNib:CellNib forCellReuseIdentifier:RunningWaterCellID];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self setRefreshEnabled:YES];
}

-(void)loadData:(NSInteger)type andPage:(NSInteger)page
{
    [self showHUD:DATA_LOAD];
    [[PersonConnect sharedPersonConnect] getUserMoneyInfo:_info.email pwd:_info.password WithType:type andPage:page success:^(id json) {
        [self hideAllHUD];
        NSDictionary *dic = (NSDictionary *)json;
        if ([BaseConnect isSucceeded:dic]) {
            _listModel = [[RunningWaterListModel alloc] initWithDictionary:dic error:nil];
            if (page == 1) {
                [_data removeAllObjects];
            }
            [_data addObjectsFromArray:_listModel.data];
            if (_data.count == 0) {
                self.defaultEmptyView.hidden = NO;
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
    [self loadData:_type andPage:1];
    [super refresh];
}

-(void)moreFresh
{
    _pageNum ++;
    [self loadData:_type andPage:_pageNum];
    [super moreFresh];
}


#pragma mark -- UITableViewDataSource && UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RunningWaterCell *cell = [tableView dequeueReusableCellWithIdentifier:RunningWaterCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell loadCell:_data[indexPath.row]];
    return cell;
}

#pragma mark -- CCSegment
-(void)selectIndex:(NSInteger)index
{
    
}
@end
