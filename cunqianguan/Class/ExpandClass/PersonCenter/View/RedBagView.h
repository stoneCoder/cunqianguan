//
//  RedBagView.h
//  cunqianguan
//
//  Created by 四三一八 on 15/3/26.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "BaseView.h"
@protocol RedBagViewDelegate<NSObject>
-(void)closeRedBagView;
-(void)tapToOpenRedBag;
@end
@interface RedBagView : BaseView
@property (weak, nonatomic) IBOutlet UIImageView *tapView;
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;
@property (strong, nonatomic) id<RedBagViewDelegate> delegate;
+(RedBagView *)initBagView;
@end
