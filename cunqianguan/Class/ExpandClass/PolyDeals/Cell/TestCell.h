//
//  TestCell.h
//  cunqianguan
//
//  Created by 四三一八 on 15/3/31.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYHModel.h"
@interface TestCell : UICollectionViewCell
@property (strong, nonatomic) UIImageView *image;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *priceLabel;
@property (strong, nonatomic) UILabel *grabLabel;
-(void)loadCell:(JYHModel *)model withType:(NSInteger)type;
@end
