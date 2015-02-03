//
//  BaseSelectView.h
//  cunqianguan
//
//  Created by 四三一八 on 15/2/3.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "BaseView.h"
@protocol BaseSelectViewDelegate<NSObject>
-(void)selectBtn:(NSInteger)index;
@end
@interface BaseSelectView : BaseView
@property (strong,nonatomic) id<BaseSelectViewDelegate> delegate;
@property (assign,nonatomic) NSInteger selectIndex;
-(void)initView:(NSArray *)btnArray;
-(void)showView;
-(void)hideView;
@end
