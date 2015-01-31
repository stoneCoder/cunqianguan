//
//  FootprintsVC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/23.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "FootPrintsVC.h"
#import "FootPrintsCell.h"


@interface FootPrintsVC ()

@end
static NSString *CellID=@"FootPrintsCell";
@implementation FootPrintsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setUpNavbtn];
    [self setUpTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUpNavbtn
{
    [self setRigthBarWithDic:@{@"images":@[@"refresh"],@"imageshover":@[@"refresh_hover"]}];
}

-(void)setUpTableView
{
    [self createTableWithStye:UITableViewStylePlain];
    UINib *cellNib = [UINib nibWithNibName:@"FootPrintsCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:CellID];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = UIColorFromRGB(0xececec);
    [self setRefreshEnabled:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)rightBtnClick:(UIButton *)btn
{
    NSLog(@"%ld------------->",(long)btn.tag);
}

#pragma mark -- UITableViewDataSource && UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //FootPrintsCell1 *cell = [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
     FootPrintsCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
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
