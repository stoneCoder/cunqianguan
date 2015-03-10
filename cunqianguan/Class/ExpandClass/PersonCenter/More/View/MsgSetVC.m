//
//  MsgSetVC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/3/10.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "MsgSetVC.h"
#import "MsgSetCell.h"
#import "BaseUtil.h"
@interface MsgSetVC ()
{
    NSArray *_localData;
}

@end
static NSString *msgSetCellId = @"MsgSetCell";
@implementation MsgSetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if ([BaseUtil isInstallApp:@"taobao://"]) {
        _localData = @[@"用淘宝客户端打开",@"消息提醒",@"通知时段"];
    }else{
        _localData = @[@"消息提醒",@"通知时段"];
    }
    [self setUpTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUpTableView
{
    [self createTableWithStye:UITableViewStylePlain];
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGTH - 64);
    
    UINib *cellNib = [UINib nibWithNibName:@"MsgSetCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:msgSetCellId];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark -- UITableViewDataSource && UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _localData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MsgSetCell *cell = [tableView dequeueReusableCellWithIdentifier:msgSetCellId];
    cell.titleLabel.text = _localData[indexPath.row];
    if (indexPath.row == _localData.count - 1) {
        cell.switchBtn.hidden = YES;
        cell.infoLabel.hidden = NO;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
@end
