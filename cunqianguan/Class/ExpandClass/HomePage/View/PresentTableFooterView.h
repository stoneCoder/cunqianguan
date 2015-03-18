//
//  PresentTableFooterView.h
//  cunqianguan
//
//  Created by 四三一八 on 15/3/18.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PresentTableFooterView : UIView
@property (weak, nonatomic) IBOutlet UILabel *firstLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;
@property (weak, nonatomic) IBOutlet UILabel *thirdLabel;
+(PresentTableFooterView *)footView;
@end
