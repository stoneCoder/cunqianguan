//
//  InviteRewardVC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/30.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "InviteRewardVC.h"
#import "RunningWaterCell.h"

@interface InviteRewardVC ()

@end
static NSString *InviteRewardCellID = @"InviteRewardCell";
@implementation InviteRewardVC

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
    self.tableView.frame = CGRectMake(10,_topView.frame.size.height+_topView.frame.origin.x + 50, SCREEN_WIDTH - 20, VIEW_HEIGHT - 184);
    UINib *cellNib = [UINib nibWithNibName:@"RunningWaterCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:InviteRewardCellID];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self setRefreshEnabled:YES];
}

#pragma mark -- UITableViewDataSource && UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView =  [[UIView alloc] initWithFrame:[tableView rectForHeaderInSection:section]];
    headView.backgroundColor = [UIColor whiteColor];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,10, 100, 20)];
    titleLabel.text = @"我的邀请";
    [headView addSubview:titleLabel];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, headView.frame.size.height, VIEW_WIDTH, 1)];
    lineView.backgroundColor = UIColorFromRGB(0xececec);
    [headView addSubview:lineView];
    return headView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RunningWaterCell *cell = [tableView dequeueReusableCellWithIdentifier:InviteRewardCellID];
    cell.timeLabel.text = @"飞翔的徐飞";
    cell.titleLabel.text = @"返利收益大于1元";
    
    NSString *infoText = @"已奖励2元";
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:infoText];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(infoText.length - 2,infoText.length - 3)];
    cell.infoLabel.attributedText = str;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
@end
