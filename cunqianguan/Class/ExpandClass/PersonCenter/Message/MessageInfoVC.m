//
//  MessageInfoVC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/28.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "MessageInfoVC.h"
#import "MessageInfoCell.h"

@interface MessageInfoVC ()

@end
static NSString *MessageInfoCellID = @"MessageInfoCell";
@implementation MessageInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setReturnBtnTitle:@"会员中心"];
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
    
    UINib *CellNib = [UINib nibWithNibName:@"MessageInfoCell" bundle:nil];
    [self.tableView registerNib:CellNib forCellReuseIdentifier:MessageInfoCellID];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    ///[self setRefreshEnabled:YES];
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
    
    MessageInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:MessageInfoCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.rightUtilityButtons = [self cellRightButtons];
    //cell.delegate = self;
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

@end
