//
//  PointView.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/30.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "PointView.h"

@implementation PointView
{
    NSDictionary *_localData;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return 4;
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
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,10, 150, 20)];
    titleLabel.text = @"VIP返利率说明";
    [headView addSubview:titleLabel];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, headView.frame.size.height, self.frame.size.width, 1)];
    lineView.backgroundColor = UIColorFromRGB(0xececec);
    [headView addSubview:lineView];
    return headView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellID = @"MoreCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellID];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
    cell.textLabel.text = [NSString stringWithFormat:@"VIP%ld",(long)(indexPath.row + 1)];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14.0f];
    cell.detailTextLabel.textColor = UIColorFromRGB(0x969696);
    NSString *fanStr = @"50%";
    if (indexPath.row == 1) {
        fanStr = @"55%";
    }else if (indexPath.row == 2){
        fanStr = @"58%";
    }else if (indexPath.row == 3){
        fanStr = @"60%";
    }
    NSString *infoText = [NSString stringWithFormat:@"最高可获利商品利润的%@返利",fanStr];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:infoText];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(infoText.length - 5,3)];
    cell.detailTextLabel.attributedText = str;
    return cell;
}

@end
