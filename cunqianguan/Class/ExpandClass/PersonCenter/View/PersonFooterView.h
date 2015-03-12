//
//  PersonFooterView.h
//  cunqianguan
//
//  Created by 四三一八 on 15/1/24.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PersonFooterDelegate<NSObject>
-(void)helpInfoClick;
-(void)loginOutClick;
@end
@interface PersonFooterView : UIView
@property (strong, nonatomic) id<PersonFooterDelegate> delegate;
+(PersonFooterView *)footerView;
@end
