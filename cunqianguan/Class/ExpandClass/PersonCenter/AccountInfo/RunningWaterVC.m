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

@interface RunningWaterVC ()<CCSegmentDelegate>
{
    BaseSegment *_segment;
    UIView *_headView;
}

@end
static NSString *RunningWaterCellID = @"RunningWaterCell";
@implementation RunningWaterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
    _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 45)];
    _segment = [[BaseSegment alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 44)];
    _segment.delegate = self;
    [_segment setItems:@[@"收入",@"提现",@"待返利",@"兑换"] isShowLine:NO WithSelectPlace:ShowSelectPlaceFromBottom];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, _segment.frame.size.height, VIEW_WIDTH, 1)];
    lineView.backgroundColor = UIColorFromRGB(0xececec);
    [_headView addSubview:_segment];
    [_headView addSubview:lineView];
}

-(void)setUpTableView
{
    [self createTableWithStye:UITableViewStylePlain];
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGTH - 64);
    
    UINib *CellNib = [UINib nibWithNibName:@"RunningWaterCell" bundle:nil];
    [self.tableView registerNib:CellNib forCellReuseIdentifier:RunningWaterCellID];
    
    self.tableView.tableHeaderView = _headView;
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self setRefreshEnabled:YES];
}

#pragma mark -- UITableViewDataSource && UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    RunningWaterCell *cell = [tableView dequeueReusableCellWithIdentifier:RunningWaterCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark -- CCSegmentDelegate
-(void)selectIndex:(NSInteger)index
{
    
}
@end
