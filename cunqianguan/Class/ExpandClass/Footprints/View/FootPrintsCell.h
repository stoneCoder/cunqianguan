//
//  FootPrintsCell.h
//  cunqianguan
//
//  Created by 四三一八 on 15/1/31.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "SWTableViewCell.h"
#import "FootModel.h"
@interface FootPrintsCell : SWTableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *productImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *oldPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *fanliLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
-(void)loadCell:(FootModel *)model;
@end
