//
//  BaseSegment.h
//  cunqianguan
//
//  Created by 四三一八 on 15/1/19.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CCSegmentDelegate <NSObject>
-(void)selectIndex:(NSInteger)index;
@end

@interface BaseSegment : UIControl

@property (nonatomic, strong) NSArray *items;

@property (nonatomic) NSUInteger selectIndex;
@property (strong, nonatomic) id<CCSegmentDelegate> delegate;

- (void)setSelectIndex:(NSUInteger)selectIndex animated:(BOOL)animated;
- (void)setBottomLineViewWidth:(CGFloat)width;
- (void)setItemTitleColorForNormal:(UIColor *)normal andForSelected:(UIColor *)selected;
- (void)setItemTitleFontSize:(CGFloat)size;
- (void)hiddenSeparatorView:(BOOL)hidden;

- (void)setItems:(NSArray *)items isShowLine:(BOOL)isShowLine;
@end
