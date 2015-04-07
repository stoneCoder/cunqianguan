//
//  PresentTableView.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/22.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "PresentTableView.h"
#import "PresentTableFooterView.h"
@implementation PresentTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}



- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section < 2) {
        return 10;
    }else{
        return 100;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 2) {
        PresentTableFooterView *footerView = [PresentTableFooterView footView];
        return footerView;
    }else{
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
        bgView.backgroundColor = UIColorFromRGB(0xececec);
        return bgView;
   }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 40)];
    headerview.backgroundColor = [UIColor whiteColor];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 2, self.frame.size.width - 10, 40)];
    titleLabel.textColor = UIColorFromRGB(0x3c3c3c);
    titleLabel.font = [UIFont systemFontOfSize:18.0f];
    titleLabel.backgroundColor = [UIColor clearColor];
    NSString *titleStr = @"";
    if (section == 0) {
        titleStr = @"什么是返利？";
    }else if (section == 1){
        titleStr = @"怎么拿返利？";
    }else if (section == 2){
        titleLabel.textColor = UIColorFromRGB(0xff5656);
        titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
        titleStr = @"新玩法";
    }
    titleLabel.text = titleStr;
    [headerview addSubview:titleLabel];
    return headerview;
}
// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    NSString *textStr = @"";
    if (indexPath.section == 0) {
        textStr = @"返利是现金。可以充话费，兑换商品，提现到支付宝或者银行卡。";
    }else if (indexPath.section == 1){
        textStr = @"从返利网去合作商家（如：淘宝、京东）下单，即可从返利网获得返利！";
    }else if (indexPath.section == 2){
        textStr = @"在\"足迹\"里，可以看到商品的具体返利，购买有返利！";
    }
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:textStr];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 2;// 字体的行间距
    //paragraphStyle.paragraphSpacing = 5;
    [attrStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, textStr.length)];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.font = [UIFont systemFontOfSize:13.0f];
    cell.textLabel.textColor = UIColorFromRGB(0x3c3c3c);
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.attributedText = attrStr;
    cell.contentView.backgroundColor = [UIColor whiteColor];
    return cell;
}
@end
