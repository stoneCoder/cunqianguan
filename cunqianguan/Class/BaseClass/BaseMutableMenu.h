//
//  BaseMutableMenu.h
//  cunqianguan
//
//  Created by 四三一八 on 15/2/2.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "BaseView.h"
#import "TouchPropagatedScrollView.h"
#import "MutableButton.h"
@class BaseMutableMenu;
@class MutableButton;
@protocol MutableMenuDelegate<NSObject>
- (void)popoverViewDidDismiss:(BaseMutableMenu *)mutableMenu;
- (void)clickAction:(MutableButton *)button;
@end
@interface BaseMutableMenu : BaseView<SegmentDelegate,UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) id<MutableMenuDelegate> delegate;

-(void)initScrollViewWithDirectionType:(NSInteger)directionType;
-(void)showView;
-(void)hideView;
@end
