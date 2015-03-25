//
//  HelpInfoVC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/3/10.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "HelpInfoVC.h"
#import "TipInfoVC.h"
#import "LocalWebVC.h"
@interface HelpInfoVC ()
{
    NSArray *_localData;
}

@end

@implementation HelpInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _localData = @[@"什么是累计获得金额",@"什么是返利",@"怎么拿返利",@"怎么样才能确保返利",@"经验值会员等级",@"如何复制商品标题",@"用户协议"];
    [self setUpTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
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
    [self createTableWithStye:UITableViewStylePlain];
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGTH - 64);
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

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
    static NSString *CellID = @"HelpInfoCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
        if (!iOS7) {
            UIView *bgView =  [[UIView alloc] initWithFrame:cell.frame];
            bgView.backgroundColor = [UIColor whiteColor];
            cell.backgroundView = bgView;
        }
    }
    cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.font = [UIFont systemFontOfSize:15.0f];
    cell.textLabel.text = _localData[indexPath.row];
    
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = UIColorFromRGB(0xececec);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = indexPath.row;
    if (index < 5) {
        NSDictionary *dic;
        TipInfoVC *infoVC = [[TipInfoVC alloc] init];
        infoVC.leftTitle = @"帮助中心";
        switch (index) {
            case 0:
                dic = @{@"title":@"什么是累计获得金额？",@"info":@"累计获得金额等于（积分+集分宝+现金）收入的总和！\n其中100积分等同于1元钱\n100集分宝等同于1元钱"};
                break;
            case 1:
                dic = @{@"title":@"什么是返利？",@"info":@"返利是现金。可以充话费，兑换商品，提现到支付宝或者银行卡!"};
                break;
            case 2:
                dic = @{@"title":@"怎么拿返利？",@"info":@"从返利网去合作商家（如：淘宝、京东）下单，可以从返利网获得返利！"};
                break;
            case 3:
                dic = @{@"title":@"怎么样才可以确保返利？",@"info":@"使用APP里的淘宝搜索，直接购买或添加到购物车，或返利到“足迹”里购买，均有返利！"};
                break;
            case 4:
                dic = @{@"title":@"经验值会员等级",@"info":@"会员等级越来，收益会越多!会员等级的升级是依靠于经验值的增长。经常使用手机签到、购物下单，保持存钱罐软件(PC软件)在线，均可获取经验值。"};
                break;
        }
        [infoVC reloadDataWith:dic];
        [self.navigationController pushViewController:infoVC animated:YES];
    }else{
        LocalWebVC *loaclWebVC = [[LocalWebVC alloc] init];
        loaclWebVC.leftTitle = @"帮助中心";
        if (index == 5) {
            loaclWebVC.loadType = 0;
        }else if (index == 6){
            loaclWebVC.loadType = 1;
        }
        [self.navigationController pushViewController:loaclWebVC animated:YES];
    }
}
@end
