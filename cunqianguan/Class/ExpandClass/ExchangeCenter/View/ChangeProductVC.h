//
//  ChangeProductVC.h
//  cunqianguan
//
//  Created by 四三一八 on 15/1/27.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "BaseTableVC.h"
#import "ExChangeModel.h"
#import "ExChangeDetailModel.h"

@interface ChangeProductVC : BaseTableVC
-(void)reloadView:(ExChangeModel *)model andDetail:(ExChangeDetailModel *)detailModel;
@end
