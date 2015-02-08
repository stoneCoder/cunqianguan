//
//  FinishInfoVC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/24.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "FinishInfoVC.h"
#import "BindAccountVC.h"
#import "RegisterVC.h"
#import "BaseSegment.h"
#import "BindAccountVC.h"

@interface FinishInfoVC ()<CCSegmentDelegate>
{
    BaseSegment *_segment;
    BindAccountVC *_accountVC;
    RegisterVC *_registerVC;
}

@end

@implementation FinishInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitleText:@"完善资料"];
    [self setUpSegment];
    [self setUpContentView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)setUpSegment
{
    _segment = [[BaseSegment alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    _segment.backgroundColor = [UIColor whiteColor];
    _segment.layer.shadowOpacity = 1;
    _segment.delegate = self;
    [_segment setItems:@[@"绑定已有账号",@"注册新账号"] isShowLine:NO WithSelectPlace:ShowSelectPlaceFromBottom];
    [self.view insertSubview:_segment aboveSubview:self.view];
}

-(void)setUpContentView
{
    CGFloat visiableY = _segment.frame.size.height;
    _accountVC = [[BindAccountVC alloc] init];
    [self addChildViewController:_accountVC];
    [_accountVC.view setFrame:CGRectMake(0, visiableY, VIEW_WIDTH, VIEW_HEIGHT - visiableY)];
    _accountVC.view.backgroundColor = UIColorFromRGB(0xececec);
    [self.view addSubview:_accountVC.view];
    
    _registerVC = [[RegisterVC alloc] init];
    [_registerVC.view setFrame:CGRectMake(0, visiableY, VIEW_WIDTH, VIEW_HEIGHT - visiableY)];
    _registerVC.view.backgroundColor = UIColorFromRGB(0xececec);
    [self addChildViewController:_registerVC];
    [self.view insertSubview:_registerVC.view belowSubview:_accountVC.view];
    
}

-(void)selectIndex:(NSInteger)index
{
    if (index == 0) {
        [self.view bringSubviewToFront:_accountVC.view];
    }else{
        [self.view bringSubviewToFront:_registerVC.view];
    }
}

@end
