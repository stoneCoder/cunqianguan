//
//  AllCheckView.h
//  cunqianguan
//
//  Created by 四三一八 on 15/3/7.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "BaseView.h"
@protocol AllCheckViewDelegate<NSObject>
-(void)allCheckAction;
-(void)cancleAction;
-(void)submitAction;
@end

@interface AllCheckView : BaseView
@property (weak, nonatomic) IBOutlet UIButton *checkBtn;
@property (strong, nonatomic) id<AllCheckViewDelegate> delegate;
+(AllCheckView *)init;
@end
