//
//  TouchPropagatedScrollView.h
//
//  Created by chen on 14/7/13.
//  Copyright (c) 2014年 chen. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SegmentDelegate <NSObject>
-(void)selectIndex:(NSInteger)index;
@end
@interface TouchPropagatedScrollView : UIScrollView
@property (nonatomic, strong) NSArray *items;

@property (nonatomic) NSUInteger selectIndex;

@property (strong, nonatomic) id<SegmentDelegate> segmentDelegate;
- (void)setItems:(NSArray *)items isShowLine:(BOOL)isShowLine;
@end
