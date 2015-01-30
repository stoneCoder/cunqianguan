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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView =  [[UIView alloc] initWithFrame:[tableView rectForHeaderInSection:section]];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,10, 100, 20)];
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
    }
    cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    cell.imageView.image = [UIImage imageNamed:@"back"];
    cell.textLabel.font = [UIFont systemFontOfSize:15.0f];
    return cell;
}

@end
