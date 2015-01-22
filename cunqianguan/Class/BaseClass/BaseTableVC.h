//
//  BaseTableVC.h
//  cunqianguan
//
//  Created by 四三一八 on 15/1/19.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "BaseVC.h"

@interface BaseTableVC : BaseVC<UITableViewDataSource, UITableViewDelegate>{}
@property(strong, nonatomic) IBOutlet UITableView *tableView;
-(void)setRefreshEnabled:(BOOL)enabled;
@end


@interface UITableView (RLBaseTableVC)
-(void)scrollToBottom;
-(void)scrollToBottomWithoutAnimation;
-(void)scrollToBottomWithVisibleHeight:(CGFloat)visibleHeight;
-(void)scrollToBottomWithVisibleHeightButAnimation:(CGFloat)visibleHeight;
-(void)scrollToBottom:(BOOL)animation withVisibleHeight:(CGFloat)visibleHeight;
@end