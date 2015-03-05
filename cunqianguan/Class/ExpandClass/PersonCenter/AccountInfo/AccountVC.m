//
//  AccountVC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/29.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "AccountVC.h"
#import "AccountCell.h"

#import "AccountEditVC.h"
#import "PersonInfo.h"
#import "PersonConnect.h"
#import "BaseConnect.h"
#import "BankModel.h"
#import "BaseUtil.h"
@interface AccountVC ()<AccountCellDelegate>
{
    PersonInfo *_info;
    BankModel *_model;
}

@end
static NSString *AccountCellID = @"AccountCell";
@implementation AccountVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _info = [PersonInfo sharedPersonInfo];
    [self setUpTableView];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadData
{
    [self showHUD:DATA_LOAD];
    [[PersonConnect sharedPersonConnect] getUserBankInfo:_info.email andPwd:_info.password success:^(id json) {
        [self hideAllHUD];
        NSDictionary *dic = (NSDictionary *)json;
        if ([BaseConnect isSucceeded:dic]) {
            _model = [[BankModel alloc] initWithDictionary:[dic objectForKey:@"data"] error:nil];
            [self.tableView reloadData];
        }
    } failure:^(NSError *err) {
        [self hideAllHUD];
    }];
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
    if (_model) {
        if (indexPath.row == 0) {
            cell.infoLabel.text = _model.alipay;
        }else if (indexPath.row == 1){
            cell.infoLabel.text = [BaseUtil transformBankCard:_model.bank];
        }
    }else{
        cell.infoLabel.text = @"未绑定";
    }
    return cell;
}

-(void)btnAction:(AccountCell *)cell
{
    AccountEditVC *accountEditVC = [[AccountEditVC alloc] init];
    if (cell.tag == 0) {
        accountEditVC.leftTitle = @"修改支付宝账号";
    }else if (cell.tag == 1){
        accountEditVC.leftTitle = @"修改银行卡账号";
    }
    accountEditVC.viewType = cell.tag;
    accountEditVC.model = _model;
    [self.navigationController pushViewController:accountEditVC animated:YES];
}
@end
