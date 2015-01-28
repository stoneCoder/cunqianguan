//
//  PersonHeaderView.h
//  cunqianguan
//
//  Created by 四三一八 on 15/1/24.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PersonHeaderDelegate<NSObject>
-(void)btnAction:(NSInteger)tag;
@end
@interface PersonHeaderView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UIImageView *progressView;
@property (weak, nonatomic) IBOutlet UIImageView *pointImageView;

@property (strong, nonatomic) id<PersonHeaderDelegate> delegate;
+(PersonHeaderView *)headerView;
@end
