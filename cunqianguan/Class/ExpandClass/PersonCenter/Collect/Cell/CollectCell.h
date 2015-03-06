//
//  CollectCell.h
//  cunqianguan
//
//  Created by 四三一八 on 15/2/9.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectModel.h"
@interface CollectCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *productImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *oldPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *saleNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *fanliLabel;
-(void)loadCell:(CollectModel *)model;
@end
