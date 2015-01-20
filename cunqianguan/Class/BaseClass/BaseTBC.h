//
//  BaseTBC.h
//  cunqianguan
//
//  Created by 四三一八 on 15/1/19.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTBC : UITabBarController
@property(nonatomic, assign) NSInteger lastSelectedIndex;//上次选中的索引值
@property(nonatomic, assign) NSInteger lastDifferentIndex;//上次选中的其他tab的索引值

@property (strong,nonatomic) UILabel * bangLab;
- (void)selectItemAtIndex:(NSInteger)index;

//设置消息badge
-(void)setBadgeNum:(NSString *)aNumStr;

-(NSString *)currentBadgeNum;
@end
