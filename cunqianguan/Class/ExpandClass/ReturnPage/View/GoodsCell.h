//
//  GoodsCell.h
//  cunqianguan
//
//  Created by 四三一八 on 15/1/22.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MongoModel.h"
@interface GoodsCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *productImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *oldPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *commissionRateLabel;
@property (weak, nonatomic) IBOutlet UILabel *saleLabel;
-(void)loadCell:(MongoModel *)mongoModel;
@end
