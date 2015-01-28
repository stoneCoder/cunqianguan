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

@interface MyOrderVC ()<CCSegmentDelegate>
{
    BaseSegment *_segment;
    BOOL _orderType;
}

@end
static NSString *TaoOrderCellID = @"TaoOrderCell";
static NSString *ShopOrderCellID = @"ShopOrderCell";
@implementation MyOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _orderType = YES;
    [self setTitleText:@"我的订单"];
    [self setUpSegment];
    [self setUpTableView];
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

-(void)setUpSegment
{
    _segment = [[BaseSegment alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 44)];
    _segment.delegate = self;
    [_segment setItems:@[@"淘宝订单",@"商城订单"] isShowLine:NO WithSelectPlace:ShowSelectPlaceFromBottom];
    [self.view addSubview:_segment];
}

-(void)setUpTableView
{
    [self createTableWithStye:UITableViewStylePlain];
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGTH - 64);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UINib *taoCellNib = [UINib nibWithNibName:@"TaoOrderCell" bundle:nil];
    [self.tableView registerNib:taoCellNib forCellReuseIdentifier:TaoOrderCellID];
    
    UINib *shopCellNib = [UINib nibWithNibName:@"ShopOrderCell" bundle:nil];
    [self.tableView registerNib:shopCellNib forCellReuseIdentifier:ShopOrderCellID];
    
    self.tableView.tableHeaderView = _segment;
    [self setRefreshEnabled:YES];
}


#pragma mark -- UITableViewDataSource && UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_orderType) {
        TaoOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:TaoOrderCellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.rightUtilityButtons = [self cellRightButtons];
        //cell.delegate = self;
        cell.containingTableView = tableView;
        [cell hideUtilityButtonsAnimated:NO];
        [cell setCellHeight:cell.frame.size.height];
        return cell;
    }else
    {
        ShopOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:ShopOrderCellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.rightUtilityButtons = [self cellRightButtons];
        //cell.delegate = self;
        cell.containingTableView = tableView;
        [cell hideUtilityButtonsAnimated:NO];
        [cell setCellHeight:cell.frame.size.height];
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
            _orderType = YES;
            [self.tableView reloadData];
            break;
         case 1:
            _orderType = NO;
            [self.tableView reloadData];
            break;
        default:
            break;
    }
}

@end
