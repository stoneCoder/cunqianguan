//
//  PolyGoodsTableCell.h
//  cunqianguan
//
//  Created by 四三一八 on 15/4/10.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TeJiaModel.h"
@interface PolyGoodsTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *productImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *isNewBtn;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *oldPriceLabel;


-(void)loadData:(TeJiaModel *)model;
@end
