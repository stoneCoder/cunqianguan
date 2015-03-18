//
//  ReturnPageTipView.h
//  cunqianguan
//
//  Created by 四三一八 on 15/3/18.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ReturnPageTipViewDelegate<NSObject>
-(void)clickAction;
@end
@interface ReturnPageTipView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *tipImageView;
@property (weak, nonatomic) IBOutlet UIButton *tipBtn;

@property (strong ,nonatomic) id<ReturnPageTipViewDelegate> delegate;

+(ReturnPageTipView *)tipView;
@end
