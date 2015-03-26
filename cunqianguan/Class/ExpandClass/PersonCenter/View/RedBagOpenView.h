//
//  RedBagOpenView.h
//  cunqianguan
//
//  Created by 四三一八 on 15/3/26.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "BaseView.h"
@protocol RedBagOpenViewDelegate<NSObject>
-(void)closeOpenView;
-(void)inviteFriend;
@end
@interface RedBagOpenView : BaseView
@property (weak, nonatomic) IBOutlet UILabel *cashLabel;
@property (weak, nonatomic) IBOutlet UILabel *successLabel;
@property (strong, nonatomic) id<RedBagOpenViewDelegate> delegate;
+(RedBagOpenView *)initBagOpenView;
@end
