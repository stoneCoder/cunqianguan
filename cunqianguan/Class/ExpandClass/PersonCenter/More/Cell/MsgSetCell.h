//
//  MsgSetCell.h
//  cunqianguan
//
//  Created by 四三一八 on 15/3/10.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MsgSetCell;
@protocol MsgSetCellDelegate<NSObject>
-(void)tapSwitch:(MsgSetCell *)cell;
//-(void)tapTimeAction:(MsgSetCell *)cell;
@end

@interface MsgSetCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIButton *switchBtn;
@property (strong, nonatomic) IBOutlet UILabel *infoLabel;

@property (strong, nonatomic) id<MsgSetCellDelegate> delegate;

@end
