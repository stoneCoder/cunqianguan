//
//  RankingListView.m
//  cunqianguan
//
//  Created by 四三一八 on 15/3/31.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "RankingListView.h"
#import "RankingListCell.h"
#import "RankingTitleCell.h"
static NSString *rankingTitleCellID = @"RankingTitleCell";
static NSString *rankingListCellID = @"RankingListCell";
@implementation RankingListView
{
    NSArray *_data;
}

/*IOS8 设置separator置顶*/
-(void)viewDidLayoutSubviews
{
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        [self setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        [self setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}

-(void)setUpTable:(NSArray *)listModel
{
    [self viewDidLayoutSubviews];
    _data = listModel;
    self.dataSource = self;
    self.delegate = self;
    self.scrollEnabled = NO;
    
    UINib *titleCellNib = [UINib nibWithNibName:@"RankingTitleCell" bundle:nil];
    [self registerNib:titleCellNib forCellReuseIdentifier:rankingTitleCellID];
    
    UINib *listCellNib = [UINib nibWithNibName:@"RankingListCell" bundle:nil];
    [self registerNib:listCellNib forCellReuseIdentifier:rankingListCellID];
    
    self.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self reloadData];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _data.count + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 40;
    }
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *headerview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 40)];
        headerview.backgroundColor = [UIColor whiteColor];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, self.frame.size.width - 10, 30)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = UIColorFromRGB(0x646464);
        titleLabel.font = [UIFont systemFontOfSize:15.0f];
        titleLabel.text = @"邀请好友奖励排行榜";
        [headerview addSubview:titleLabel];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, headerview.frame.size.height + headerview.frame.origin.x, self.frame.size.width, 2)];
        lineView.backgroundColor = UIColorFromRGB(0x58ded4);
        [headerview addSubview:lineView];
        return headerview;
    }
    return nil;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        RankingTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:rankingTitleCellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    RankingListCell *cell = [tableView dequeueReusableCellWithIdentifier:rankingListCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell loadCell:_data[indexPath.row - 1] andIndex:indexPath.row];
    return cell;
}



/*IOS8 设置separator置顶*/
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (iOS7) {
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            [cell setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            [cell setLayoutMargins:UIEdgeInsetsZero];
        }
    }
}
@end
