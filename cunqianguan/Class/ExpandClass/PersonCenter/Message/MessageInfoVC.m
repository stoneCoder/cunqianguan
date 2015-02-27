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
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MessageInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:MessageInfoCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.rightUtilityButtons = [self cellRightButtons];
    cell.delegate = self;
    MsgModel *model = _data[indexPath.row];
    cell.tag = [model.msgId integerValue];;
    [cell loadCell:model];
    cell.containingTableView = tableView;
    [cell hideUtilityButtonsAnimated:NO];
    [cell setCellHeight:cell.frame.size.height];
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
    [rightUtilityButtons sw_addUtilityButtonWithColor:UIColorFromRGB(0xff2222) title:@"删除"];
    return rightUtilityButtons;
}

#pragma mark - SWTableViewCell delegate
- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index{
    NSArray *dataArr = @[@(cell.tag)];
    switch (index) {
        case 0:
            // 置顶
            [self deleteMsg:dataArr];
            break;
    }
}

-(void)deleteMsg:(NSArray *)msgArray
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
