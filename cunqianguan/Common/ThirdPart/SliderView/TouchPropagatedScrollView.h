//
//  TouchPropagatedScrollView.h
//
//  Created by chen on 14/7/13.
//  Copyright (c) 2014年 chen. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, DirectionType) {
    HorizontalDirection, //水平
    VerticalDirection, //垂直
};
@protocol SegmentDelegate <NSObject>
-(void)selectIndex:(NSInteger)index;
-(void)selectTitle:(NSString *)title;
@end
@interface TouchPropagatedScrollView : UIScrollView
@property (nonatomic, strong) NSArray *items;
@property (assign,nonatomic) NSInteger DirectionType;
@property (assign,nonatomic) BOOL isShowSelectBackgroundColor;
@property (nonatomic) NSUInteger selectIndex;

@property (strong, nonatomic) id<SegmentDelegate> segmentDelegate;
- (void)setItems:(NSArray *)items isShowLine:(BOOL)isShowLine;
@end
