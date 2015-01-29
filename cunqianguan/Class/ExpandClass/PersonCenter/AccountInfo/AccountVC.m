//
//  AccountVC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/29.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "AccountVC.h"
#import "AccountCell.h"

@interface AccountVC ()<AccountCellDelegate>

@end
static NSString *AccountCellID = @"AccountCell";
@implementation AccountVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
-(void)setUpTableView
{
    [self createTableWithStye:UITableViewStylePlain];
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGTH - 64);
    self.tableView.backgroundColor = UIColorFromRGB(0xececec);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UINib *CellNib = [UINib nibWithNibName:@"AccountCell" bundle:nil];
    [self.tableView registerNib:CellNib forCellReuseIdentifier:AccountCellID];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

#pragma mark -- UITableViewDataSource && UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 108;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    AccountCell *cell = [tableView dequeueReusableCellWithIdentifier:AccountCellID];
    cell.tag = indexPath.row;
    cell.cellDelegate = self;
    cell.containingTableView = tableView;
    [cell hideUtilityButtonsAnimated:NO];
    [cell setCellHeight:cell.frame.size.height];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        [cell.cellBtn setTitle:@"修改支付宝账号" forState:UIControlStateNormal];
    }else if (indexPath.row == 1){
        [cell.cellBtn setTitle:@"修改银行卡账号" forState:UIControlStateNormal];
        [cell.cellBtn setBackgroundColor:UIColorFromRGB(0xF14349)];
    }
    return cell;
}

-(void)btnAction:(AccountCell *)cell
{
    NSLog(@"%ld--------->",(long)cell.tag);
}
@end
