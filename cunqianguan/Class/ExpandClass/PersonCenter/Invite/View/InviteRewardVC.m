//
//  InviteRewardVC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/30.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "InviteRewardVC.h"
#import "RunningWaterCell.h"
#import "PersonInfo.h"
#import "PersonConnect.h"
#import "BaseConnect.h"
#import "InviteListModel.h"
@interface InviteRewardVC ()
{
    PersonInfo *_info;
    NSMutableArray *_data;
    NSInteger _pageNum;
}

@end
static NSString *InviteRewardCellID = @"InviteRewardCell";
@implementation InviteRewardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _pageNum = 1;
    _info = [PersonInfo sharedPersonInfo];
    _data = [NSMutableArray array];
    [self setUpTableView];
    [self loadDataWith:_info.userId andPage:_pageNum];
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
-(void)setUpTableView
{
    [self createTableWithStye:UITableViewStylePlain];
    UINib *cellNib = [UINib nibWithNibName:@"RunningWaterCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:InviteRewardCellID];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self setRefreshEnabled:YES];
    
    CGFloat visiableY = _topView.frame.size.height + _topView.frame.origin.y + 30;
    self.tableView.frame = CGRectMake(10,visiableY, SCREEN_WIDTH - 20, SCREEN_HEIGTH - visiableY - 64);
}

#pragma mark -- 加载数据
-(void)loadDataWith:(NSString *)userId andPage:(NSInteger)page
{
    [self showHUD:DATA_LOAD];
    [[PersonConnect sharedPersonConnect] getUserInvite:_info.userId page:page success:^(id json) {
        [self hideAllHUD];
        NSDictionary *dic = (NSDictionary *)json;
        if ([BaseConnect isSucceeded:dic]) {
            NSDictionary *data  = [dic objectForKey:@"data"];
            InviteListModel *listModel = [[InviteListModel alloc] initWithDictionary:data error:nil];
            if(page == 1){
                NSNumber *fanliTotle = [data objectForKey:@"fanlimoneyTotal"];
                if (![fanliTotle isEqual:[NSNull null]]) {
                    _totalMoneyLabel.text = [[NSString alloc] initWithFormat:@"%@",fanliTotle];
                }
                NSNumber *userTotle = [data objectForKey:@"userTotal"];
                if (![userTotle isEqual:[NSNull null]] && userTotle != nil) {
                    _totalInviteLabel.text = [[NSString alloc] initWithFormat:@"%@",userTotle];
                }
                [_data removeAllObjects];
            }
            [_data addObjectsFromArray:listModel.moneylog];
            if (_data.count == 0) {
                self.defaultEmptyView.hidden = NO;
                self.defaultEmptyView.frame = self.tableView.frame;
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
    [self loadDataWith:_info.userId andPage:1];
    [super refresh];
}

-(void)moreFresh
{
    _pageNum ++;
    [self loadDataWith:_info.userId andPage:_pageNum];
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView =  [[UIView alloc] initWithFrame:[tableView rectForHeaderInSection:section]];
    headView.backgroundColor = [UIColor whiteColor];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,10, 100, 20)];
    titleLabel.text = @"我的邀请";
    [headView addSubview:titleLabel];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, headView.frame.size.height, VIEW_WIDTH, 1)];
    lineView.backgroundColor = UIColorFromRGB(0xececec);
    [headView addSubview:lineView];
    return headView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RunningWaterCell *cell = [tableView dequeueReusableCellWithIdentifier:InviteRewardCellID];
    [cell loadCellWith:_data[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
@end
