//
//  EmptyView.h
//  cunqianguan
//
//  Created by 四三一八 on 15/3/12.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "BaseView.h"

@interface DefaultEmptyView : BaseView
@property (weak, nonatomic) IBOutlet UIImageView *emptyImage;
@property (weak, nonatomic) IBOutlet UILabel *emptyInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *emptydetailInfoLabel;
@property (weak, nonatomic) IBOutlet UIButton *inviteBtn;
+(DefaultEmptyView *)init;
@end
