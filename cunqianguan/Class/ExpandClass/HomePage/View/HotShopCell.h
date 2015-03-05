//
//  HotShopCell.h
//  cunqianguan
//
//  Created by 四三一八 on 15/3/5.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotShopModel.h"
@interface HotShopCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
-(void)loadCell:(HotShopModel *)model;
@end
