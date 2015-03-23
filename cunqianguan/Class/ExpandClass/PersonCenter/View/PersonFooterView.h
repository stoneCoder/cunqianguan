//
//  PersonFooterView.h
//  cunqianguan
//
//  Created by 四三一八 on 15/1/24.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonInfo.h"
@protocol PersonFooterDelegate<NSObject>
-(void)helpInfoClick;
-(void)loginOutClick;
@end
@interface PersonFooterView : UIView
@property (strong, nonatomic) IBOutlet UILabel *priceLable;
@property (weak, nonatomic) IBOutlet UIButton *quiteBtn;
@property (strong, nonatomic) id<PersonFooterDelegate> delegate;
+(PersonFooterView *)footerView;
-(void)loadView:(PersonInfo *)info;
@end
