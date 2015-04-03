//
//  SDCycleScrollView.h
//  SDCycleScrollView
//
//  Created by aier on 15-3-22.
//  Copyright (c) 2015年 GSD. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    SDCycleScrollViewPageContolAlimentRight,
    SDCycleScrollViewPageContolAlimentCenter
} SDCycleScrollViewPageContolAliment;

@class SDCycleScrollView;

typedef void (^SDCycleScrollViewDidSelectItemBlock)(NSInteger atIndex);
@interface SDCycleScrollView : UIView

@property (nonatomic, strong) NSArray *localizationImagesGroup; // 本地图片数组
@property (nonatomic, strong) NSArray *titlesGroup;
@property (nonatomic, assign) CGFloat autoScrollTimeInterval;
@property (nonatomic, strong) SDCycleScrollViewDidSelectItemBlock selectItemBlock;

// 自定义样式
@property (nonatomic, assign) SDCycleScrollViewPageContolAliment pageControlAliment; // 分页控件位置
@property (nonatomic, assign) CGSize pageControlDotSize; // 分页控件小圆标大小
@property (nonatomic, strong) UIColor *dotColor; // 分页控件小圆标颜色
@property (nonatomic, strong) UIColor *titleLabelTextColor;
@property (nonatomic, strong) UIFont *titleLabelTextFont;
@property (nonatomic, strong) UIColor *titleLabelBackgroundColor;
@property (nonatomic, assign) CGFloat titleLabelHeight;
@property (nonatomic, strong) UIImage *currentDotImage;
@property (nonatomic, strong) UIImage *dotImage;

+ (instancetype)cycleScrollViewWithFrame:(CGRect)frame imagesGroup:(NSArray *)imagesGroup;
@end
