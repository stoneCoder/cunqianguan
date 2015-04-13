//
//  TouchPropagatedScrollView.h
//
//  Created by chen on 14/7/13.
//  Copyright (c) 2014年 chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TouchPropagatedScrollView.h"

@protocol DynamicBtnScrollViewDelegate <NSObject>
-(void)selectIndex:(NSInteger)index;
@end
@interface DynamicBtnScrollView : UIScrollView
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) NSArray *itemsWidth;
@property (assign,nonatomic) NSInteger DirectionType;
@property (assign,nonatomic) BOOL isShowSelectBackgroundColor;
@property (assign, nonatomic) BOOL isBorderStyle;
@property (nonatomic) NSUInteger selectIndex;

@property (strong, nonatomic) id<DynamicBtnScrollViewDelegate> dynamicDelegate;
- (void)setItems:(NSArray *)items withItemWidth:(NSArray *)itemWidth isShowSeparatorLine:(BOOL)isShowSeparatorLine;
@end
