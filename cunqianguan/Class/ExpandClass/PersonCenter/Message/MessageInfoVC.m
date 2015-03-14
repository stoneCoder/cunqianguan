//
//  MessageInfoVC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/28.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "MessageInfoVC.h"
#import "MessageInfoCell.h"

#import "PersonConnect.h"
#import "BaseConnect.h"
#import "MsgListModel.h"
#import "PersonInfo.h"

#import "BaseUtil.h"
@interface MessageInfoVC ()<SWTableViewCellDelegate>

@end
static NSString *MessageInfoCellID = @"MessageInfoCell";
@implementation MessageInfoVC
{
    NSMutableArray *_data;
    MsgListModel *_listModel;
    NSInteger _pageNum;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _data = [NSMutableArray array];
    _pageNum = 1;
    [self setUpTableView];
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
-(void)setUpTableView
{
    [self createTableWithStye:UITableViewStylePlain];
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGTH - 64);
    
    UINib *CellNib = [UINib nibWithNibName:@"MessageInfoCell" bundle:nil];
    [self.tableView registerNib:CellNib forCellReuseIdentifier:MessageInfoCellID];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self setRefreshEnabled:YES];
}

-(void)loadData:(NSInteger)page
{
    [self showHUD:DATA_LOAD];
    [[PersonConnect sharedPersonConnect] getMessageInfo:[PersonInfo sharedPersonInfo].userId withPage:page success:^(id json) {
        [self hideAllHUD];
        NSDictionary *dic = (NSDictionary *)json;
        if ([BaseConnect isSucceeded:dic]) {
            _listModel = [[MsgListModel alloc] initWithDictionary:dic error:nil];
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
    MsgModel *model = _data[indexPath.row];
    return [self mathCellHeigth:model.contents];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MessageInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:MessageInfoCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.rightUtilityButtons = [self cellRightButtons];
    cell.delegate = self;
    cell.tag = indexPath.row;
     MsgModel *model = _data[indexPath.row];
    [cell loadCell:model];
    cell.containingTableView = tableView;
    [cell hideUtilityButtonsAnimated:NO];
    [cell setCellHeight:[self mathCellHeigth:model.contents]];
    return cell;
}

#pragma mark -- Private
-(CGFloat)mathCellHeigth:(NSString *)str
{
    return [BaseUtil getHeightByString:str font:[UIFont systemFontOfSize:13.0f] allwidth:SCREEN_WIDTH - 40] + 30;
}

/**
 *  Cell滑动按钮
 *
 *  @return NSArray
 */
- (NSArray *)cellRightButtons
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray array];
    [rightUtilityButtons sw_addUtilityButtonWithColor:UIColorFromRGB(0xff2222) title:@"删除"];
    return rightUtilityButtons;
}

#pragma mark - SWTableViewCell delegate
- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index{
    MsgModel *model = _data[cell.tag];
    NSArray *dataArr = @[model.msgId];
    NSString *str = [dataArr componentsJoinedByString:@","];
    switch (index) {
        case 0:
            // 置顶
            [self deleteMsg:str];
            break;
    }
}

-(void)deleteMsg:(NSString *)msgArray
{
    [self showHUD:ACTION_LOAD];
    [[PersonConnect sharedPersonConnect] delMessage:msgArray success:^(id json) {
        [self hideAllHUD];
        NSDictionary *dic = (NSDictionary *)json;
        if ([BaseConnect isSucceeded:dic]) {
            [self loadData:1];
        }
    } failure:^(NSError *err) {
        [self hideAllHUD];
    }];
}

- (BOOL)swipeableTableViewCellShouldHideUtilityButtonsOnSwipe:(SWTableViewCell *)cell{
    return YES;
}


@end
