//
//  TapActionView.h
//  cunqianguan
//
//  Created by 四三一八 on 15/1/19.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "BaseView.h"
#import "HighlightView.h"
@protocol TapActionViewDelegate<NSObject>
-(void)tapViewAction:(UIView *)tapView;
@end

@interface TapActionView : BaseView
@property (weak, nonatomic) IBOutlet HighlightView *taobaoView;
@property (weak, nonatomic) IBOutlet HighlightView *zujiView;
@property (weak, nonatomic) IBOutlet HighlightView *juyouhuiView;
@property (weak, nonatomic) IBOutlet HighlightView *fanligouView;
@property (weak, nonatomic) IBOutlet HighlightView *duihuanView;
@property (weak, nonatomic) IBOutlet HighlightView *shopView;
@property (weak, nonatomic) IBOutlet HighlightView *myView;
@property (weak, nonatomic) IBOutlet UIImageView *tipImage;

@property (strong,nonatomic) id<TapActionViewDelegate> delegate;
+(TapActionView *)init;

@end
