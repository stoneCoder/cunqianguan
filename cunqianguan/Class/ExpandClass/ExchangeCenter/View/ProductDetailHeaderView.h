//
//  ProductDetailHeaderView.h
//  cunqianguan
//
//  Created by 四三一八 on 15/1/27.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExChangeModel.h"
@interface ProductDetailHeaderView : UIView
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *pointLabel;
+(ProductDetailHeaderView *)headerView;
-(void)loadData:(ExChangeModel *)model;
@end
