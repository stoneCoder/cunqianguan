//
//  ShopOrderCell.h
//  cunqianguan
//
//  Created by 四三一八 on 15/1/28.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "SWTableViewCell.h"
#import "OrderModel.h"
@interface ShopOrderCell : SWTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderNumLabel;
@property (weak, nonatomic) IBOutlet UIImageView *productImage;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLable;
-(void)loadCell:(OrderModel *)model;
@end
