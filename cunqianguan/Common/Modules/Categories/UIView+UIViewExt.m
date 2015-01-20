//
//  UIView+UIViewExt.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/19.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "UIView+UIViewExt.h"
#import "MBProgressHUD.h"

@implementation UIView (UIViewExt)
#pragma mark - About Position
-(void)setPostion:(CGPoint)point{
    self.frame = CGRectMake(point.x, point.y, self.frame.size.width, self.frame.size.height);
}

-(NSInteger)bottomY{
    return self.frame.size.height + self.frame.origin.y;
}

-(NSInteger)rightX{
    return self.frame.size.width + self.frame.origin.x;
}

-(NSInteger)leftX{
    return self.frame.origin.x;
}
-(NSInteger)topY{
    return self.frame.origin.y;
}


#pragma mark - HUD
/**
 *  功能:显示hud
 */
- (MBProgressHUD *)showHUD{
    return [MBProgressHUD showHUDAddedTo:self animated:YES];
}
/**
 *  功能:显示字符串hud
 */
- (MBProgressHUD*)showHUD:(NSString *)aMessage
{
    [self hideHUD:NO];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = aMessage;
    return hud;
}
/**
 *  功能:显示字符串hud几秒钟时间
 */
- (MBProgressHUD *)showStringHUD:(NSString *)aMessage second:(int)aSecond{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = aMessage;
    [self performSelector:@selector(hideHUD) withObject:nil afterDelay:aSecond];
    return hud;
}
/**
 *  功能:隐藏hud
 */
- (void)hideHUD
{
    [MBProgressHUD hideHUDForView:self animated:YES];
}

- (void)hideHUD:(BOOL)animated
{
    [MBProgressHUD hideHUDForView:self animated:animated];
}

- (void)hideAllHUD
{
    [MBProgressHUD hideAllHUDsForView:self animated:YES];
}

#pragma mark -
- (UIView *)findFirstResponder
{
    if (self.isFirstResponder) {
        return self;
    }
    
    for (UIView *subView in self.subviews) {
        UIView *firstResponder = [subView findFirstResponder];
        
        if (firstResponder != nil) {
            return firstResponder;
        }
    }
    
    return nil;
}
@end
