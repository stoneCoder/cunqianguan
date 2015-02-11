//
//  PolyDetailHeaderView.h
//  cunqianguan
//
//  Created by 四三一八 on 15/2/11.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PolyDetailHeaderView : UIView
@property (weak, nonatomic) IBOutlet UIView *nameView;
@property (weak, nonatomic) IBOutlet UILabel *productTitle;
+(PolyDetailHeaderView *)headerView;
@end
