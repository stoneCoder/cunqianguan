//
//  MyOrderVC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/28.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "MyOrderVC.h"
#import "BaseSegment.h"

#import "TaoOrderCell.h"
#import "ShopOrderCell.h"

#import "PersonConnect.h"
#import "BaseConnect.h"
#import "PersonInfo.h"
#import "OrderListModel.h"

@interface MyOrderVC ()<CCSegmentDelegate>
{
    NSInteger _orderType;
    NSMutableArray *_data;
    NSInteger _pageNum;
    PersonInfo *_info;
    OrderListModel *_listModel;
}

@end
static NSString *TaoOrderCellID = @"TaoOrderCell";
static NSString *ShopOrderCellID = @"ShopOrderCell";
@implementation MyOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _orderType = 0;
    _pageNum = 1;
    _data = [NSMutableArray array];
    _info = [PersonInfo sharedPersonInfo];
    [self setUpTableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidCurrentView:(NSInteger)type
{
    _orderType = type;
    [self loadDataWith:_orderType andPage:_pageNum];
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
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGTH - 104);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UINib *taoCellNib = [UINib nibWithNibName:@"TaoOrderCell" bundle:nil];
    [self.tableView registerNib:taoCellNib forCellReuseIdentifier:TaoOrderCellID];
    
    UINib *shopCellNib = [UINib nibWithNibName:@"ShopOrderCell" bundle:nil];
    [self.tableView registerNib:shopCellNib forCellReuseIdentifier:ShopOrderCellID];
    
    [self setRefreshEnabled:YES];
}

/*type 0 淘宝 1 商城*/
-(void)loadDataWith:(NSInteger)type andPage:(NSInteger)page
{
    [self showHUD:DATA_LOAD];
    [[PersonConnect sharedPersonConnect] getOrderInfo:_info.email pwd:_info.password withType:type andPage:page success:^(id json) {
        [self hideAllHUD];
        NSDictionary *dic = (NSDictionary *)json;
        if ([BaseConnect isSucceeded:dic]) {
            _listModel = [[OrderListModel alloc] initWithDictionary:dic error:nil];
            if (page == 1) {
                [_data removeAllObjects];
            }
            [_data addObjectsFromArray:_listModel.data];
            if (type == 0 && _data.count == 0) {
                self.defaultEmptyView.hidden = NO;
                self.defaultEmptyView.emptydetailInfoLabel.hidden = NO;
                self.tableView.hidden = YES;
            }else if (type == 1 && _data.count == 0){
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
    [self loadDataWith:_orderType andPage:1];
    [super refresh];
}

-(void)moreFresh
{
    _pageNum ++;
    [self loadDataWith:_orderType andPage:_pageNum];
    [super moreFresh];
}



#pragma mark -- UITableViewDataSource && UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_orderType == 0) {
        TaoOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:TaoOrderCellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //cell.rightUtilityButtons = [self cellRightButtons];
        //cell.delegate = self;
        cell.containingTableView = tableView;
        [cell hideUtilityButtonsAnimated:NO];
        [cell setCellHeight:cell.frame.size.height];
        [cell loadCell:_data[indexPath.row]];
        return cell;
    }else
    {
        ShopOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:ShopOrderCellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //cell.rightUtilityButtons = [self cellRightButtons];
        //cell.delegate = self;
        cell.containingTableView = tableView;
        [cell hideUtilityButtonsAnimated:NO];
        [cell setCellHeight:cell.frame.size.height];
        [cell loadCell:_data[indexPath.row]];
        return cell;
    }
    
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

#pragma mark -- CCSegmentDelegate
-(void)selectIndex:(NSInteger)index
{
    switch (index) {
        case 0:
            _orderType = 0;
            [self loadDataWith:_orderType andPage:1];
            break;
         case 1:
            _orderType = 1;
            [self loadDataWith:_orderType andPage:1];
            break;
        default:
            break;
    }
}

@end
