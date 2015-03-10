//
//  PopView.h
//  GM86
//
//  Created by Brian on 14-7-18.
//  Copyright (c) 2014年 WHZM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopViewCell.h"
@interface PopView : UIView
@property (strong,nonatomic) PopViewCell *myAttentionView;
@property (strong,nonatomic) PopViewCell *manageAttentionView;
@end
