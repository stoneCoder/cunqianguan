//
//  ChangeRootVC.h
//  cunqianguan
//
//  Created by 四三一八 on 15/1/27.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "BaseVC.h"
#import "ExChangeModel.h"
@interface ChangeRootVC : BaseVC
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIButton *actionBtn;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (assign, nonatomic) BOOL isCanChange;
@property (strong, nonatomic) ExChangeModel *model;
@end
