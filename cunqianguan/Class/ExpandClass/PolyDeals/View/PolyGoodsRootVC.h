//
//  PolyGoodsRootVC.h
//  cunqianguan
//
//  Created by 四三一八 on 15/2/11.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "BaseVC.h"
@interface PolyGoodsRootVC : BaseVC
@property (weak, nonatomic) IBOutlet UIButton *actionBtn;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (strong, nonatomic) NSString *goodKey;
@property (weak, nonatomic) IBOutlet UILabel *countDownLabel;
@property (weak, nonatomic) IBOutlet UILabel *grabLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@end
