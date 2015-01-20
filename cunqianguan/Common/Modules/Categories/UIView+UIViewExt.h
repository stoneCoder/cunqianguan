//
//  UIView+UIViewExt.h
//  cunqianguan
//
//  Created by 四三一八 on 15/1/19.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MBProgressHUD;
@interface UIView (UIViewExt)

-(void)setPostion:(CGPoint)point;
-(NSInteger)bottomY;
-(NSInteger)rightX;
-(NSInteger)leftX;
-(NSInteger)topY;


- (MBProgressHUD*)showHUD;
- (MBProgressHUD*)showHUD:(NSString *)aMessage;
- (MBProgressHUD*)showStringHUD:(NSString *)aMessage second:(int)aSecond;
- (void)hideHUD;
- (void)hideHUD:(BOOL)animated;
- (void)hideAllHUD;

- (UIView *)findFirstResponder;

@end
