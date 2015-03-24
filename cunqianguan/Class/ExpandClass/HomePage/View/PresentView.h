//
//  PresentView.h
//  cunqianguan
//
//  Created by 四三一八 on 15/3/24.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "BaseView.h"
#import "PresentTableView.h"
@protocol PresentViewDelegate<NSObject>
-(void)hidePresentMenu;
@end
@interface PresentView : BaseView
@property (strong, nonatomic) UIButton *closeBtn;
@property (strong, nonatomic) id<PresentViewDelegate> delegate;
@end
