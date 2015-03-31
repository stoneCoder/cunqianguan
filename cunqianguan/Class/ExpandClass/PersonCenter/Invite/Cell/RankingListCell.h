//
//  RankingListCell.h
//  cunqianguan
//
//  Created by 四三一八 on 15/3/31.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RankingModel.h"
@interface RankingListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIButton *rankingTag;
-(void)loadCell:(RankingModel *)model andIndex:(NSInteger)index;
@end
