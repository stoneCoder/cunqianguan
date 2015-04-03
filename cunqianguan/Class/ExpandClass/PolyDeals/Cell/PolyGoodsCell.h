//
//  PolyGoodsCell.h
//  cunqianguan
//
//  Created by 四三一八 on 15/1/23.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYHModel.h"
@interface PolyGoodsCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *productImage;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *qLabel;
@property (weak, nonatomic) IBOutlet UIImageView *hotTipImage;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *height;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *width;

-(void)loadCell:(JYHModel *)model withType:(NSInteger)type;
@end
