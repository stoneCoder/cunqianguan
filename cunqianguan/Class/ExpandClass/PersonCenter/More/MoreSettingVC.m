//
//  MoreSettingVC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/28.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "MoreSettingVC.h"
#import "SignatureVC.h"
#import "HelpInfoVC.h"
#import "MsgSetVC.h"
@interface MoreSettingVC ()
{
    NSDictionary *_localData;
    NSDictionary *_localImageData;
}

@end

@implementation MoreSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _localData = @{@"0":@[/*@"检查更新",*/@"意见反馈",@"帮助中心",@"消息设置"],@"1":@[@"清理缓存",@"关于我们"]};
    _localImageData = @{@"0":@[/*@"more_01",*/@"more_02",@"more_03",@"more_04"],@"1":@[@"more_05",@"more_06"]};
    [self setUpTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];
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
    [self createTableWithStye:UITableViewStyleGrouped];
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGTH - 64);
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
    static NSString *CellID = @"MoreCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
    }
    cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    NSString *imageName = [_localImageData objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section]][indexPath.row];
    cell.imageView.image = [UIImage imageNamed:imageName];
    cell.textLabel.font = [UIFont systemFontOfSize:15.0f];
    cell.textLabel.text = [_localData objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section]][indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = indexPath.row;
    if(index == 0){
        SignatureVC *signatureVC = [[SignatureVC alloc] init];
        signatureVC.leftTitle = @"意见反馈";
        [self.navigationController pushViewController:signatureVC animated:YES];
    }else if(index == 1){
        HelpInfoVC *helpInfoVC = [[HelpInfoVC alloc] init];
        helpInfoVC.leftTitle = @"帮助中心";
        [self.navigationController pushViewController:helpInfoVC animated:YES];
    }else if(index == 2){
        MsgSetVC *msgSetVC = [[MsgSetVC alloc] init];
        msgSetVC.leftTitle = @"消息设置";
        [self.navigationController pushViewController:msgSetVC animated:YES];
    }
}

@end
