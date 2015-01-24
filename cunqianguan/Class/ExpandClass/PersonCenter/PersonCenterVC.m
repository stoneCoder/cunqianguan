//
//  PersonCenterVC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/24.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "PersonCenterVC.h"
#import "PersonInfoCell.h"
#import "PersonFooterView.h"

@interface PersonCenterVC ()
{
    NSDictionary *_localData;
}

@end
static NSString *CellID = @"PersonInfoCell";
static NSString *FooterViewID = @"PersonFooterView";
@implementation PersonCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _localData = @{@"0":@[@"现金",@"淘宝集分宝",@"我的积分"],@"1":@[@"我的订单",@"账户明细"],@"2":@[@"收款账号",@"收货地址"],@"3":@[@"邀请好友",@"更多"]};
    [self setTitleText:@"会员中心"];
    [self setUpNavBtn];
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
-(void)setUpNavBtn
{
    [self setRigthBarWithDic:@{@"images":@[@"refresh"],@"imageshover":@[@"refresh_hover"]}];
}

-(void)setUpTableView
{
    [self createTableWithStye:UITableViewStyleGrouped];
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGTH - 64);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UINib *cellNib = [UINib nibWithNibName:@"PersonInfoCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:CellID];
    
    PersonFooterView *personFooterView = [PersonFooterView footerView];
    personFooterView.backgroundColor = self.tableView.backgroundColor;
    [personFooterView setFrame:CGRectMake(0, 0, VIEW_WIDTH, 120)];
    self.tableView.tableFooterView = personFooterView;
}

#pragma mark -- UITableViewDataSource && UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _localData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[_localData objectForKey:[NSString stringWithFormat:@"%ld",(long)section]] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    PersonInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    cell.titleLabel.text = [_localData objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section]][indexPath.row];
    return cell;
}

@end
