//
//  RankingListView.h
//  cunqianguan
//
//  Created by 四三一八 on 15/3/31.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "BaseTableView.h"

@interface RankingListView : BaseTableView<UITableViewDelegate,UITableViewDataSource>
-(void)setUpTable:(NSArray *)listModel;
@end
