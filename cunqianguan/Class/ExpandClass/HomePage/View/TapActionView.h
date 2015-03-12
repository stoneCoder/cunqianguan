//
//  TapActionView.h
//  cunqianguan
//
//  Created by 四三一八 on 15/1/19.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "BaseView.h"

@protocol TapActionViewDelegate<NSObject>
-(void)tapViewAction:(UIView *)tapView;
@end

@interface TapActionView : BaseView
@property (weak, nonatomic) IBOutlet UIView *taobaoView;
@property (weak, nonatomic) IBOutlet UIView *zujiView;
@property (weak, nonatomic) IBOutlet UIView *juyouhuiView;
@property (weak, nonatomic) IBOutlet UIView *fanligouView;
@property (weak, nonatomic) IBOutlet UIView *duihuanView;
@property (weak, nonatomic) IBOutlet UIView *shopView;
@property (weak, nonatomic) IBOutlet UIView *myView;
@property (weak, nonatomic) IBOutlet UIImageView *tipImage;

@property (strong,nonatomic) id<TapActionViewDelegate> delegate;
+(TapActionView *)init;

@end
