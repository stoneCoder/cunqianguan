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
@protocol MutableMenuDelegate<NSObject>
- (void)popoverViewDidDismiss:(BaseMutableMenu *)mutableMenu;
@end
@interface BaseMutableMenu : BaseView<SegmentDelegate,UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) id<MutableMenuDelegate> delegate;

-(void)initScrollView:(NSDictionary *)scrollMenuDic WithDirectionType:(NSInteger)directionType;
-(void)showView;
-(void)hideView;
@end
