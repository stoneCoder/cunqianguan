//
//  PolyGoodsRootVC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/2/11.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "PolyGoodsRootVC.h"
#import "PolyGoodsDetailVC.h"

#import "PopoverView.h"
#import "PopView.h"

#import "PersonInfo.h"
#import "JYHDetailModel.h"
#import "JYHConnect.h"
#import "BaseConnect.h"
#import "BaseUtil.h"
@interface PolyGoodsRootVC ()
{
    PolyGoodsDetailVC *_polyGoodsDetailVC;
    JYHDetailModel *_detailModel;
    NSTimer *_countDownTimer;
    NSInteger _countDownTime;
    
    UIButton *rigthButton;
}

@end

@implementation PolyGoodsRootVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setUpNavBtn];
    [self setUpTableView];
    [self loadData:_model];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [_countDownTimer invalidate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)setUpTableView
{
    _actionBtn.layer.cornerRadius = 2;
    _actionBtn.layer.masksToBounds = YES;
    _bottomView.layer.shadowOpacity = 0.1;
    _polyGoodsDetailVC = [[PolyGoodsDetailVC alloc] init];
    [self addChildViewController:_polyGoodsDetailVC];
    [self.view insertSubview:_polyGoodsDetailVC.view belowSubview:_bottomView];
}

-(void)loadData:(JYHModel *)model
{
    [self showHUD:DATA_LOAD];
    PersonInfo *info = [PersonInfo sharedPersonInfo];
    NSString *goodKey = [NSString stringWithFormat:@"1000_%@",model.productId];
    [[JYHConnect sharedJYHConnect] getJYHGoodById:info.userId andGoodKey:goodKey success:^(id json) {
        [self hideAllHUD];
        NSDictionary *dic = (NSDictionary *)json;
        if ([BaseConnect isSucceeded:dic]) {
            NSDictionary *data = [dic objectForKey:@"data"];
            _detailModel = [[JYHDetailModel alloc] initWithDictionary:data error:nil];
            [self refreshBottomView];
            [_polyGoodsDetailVC reloadView:_detailModel];
        }
    } failure:^(NSError *err) {
        [self hideAllHUD];
    }];
}

-(void)setUpNavBtn
{
    rigthButton = [[UIButton alloc] initWithFrame:CGRectMake(0,0,22,22)];
    [rigthButton setBackgroundImage:[UIImage imageNamed:@"left_menu"] forState:UIControlStateNormal];
    [rigthButton addTarget:self action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc] initWithCustomView:rigthButton];
    self.navigationItem.rightBarButtonItem = rightBtnItem;
}

-(void)showMenu
{
    CGPoint point=CGPointMake(CGRectGetMidX(rigthButton.frame), CGRectGetMinY(rigthButton.frame));
    PopView *popView = [[PopView alloc] initWithFrame:CGRectMake(0, 0, 155, 60)];
    //    [popView.myAttentionView addTarget:self action:@selector(changeDiscoveryList) forControlEvents:UIControlEventTouchUpInside];
    //    [popView.manageAttentionView addTarget:self action:@selector(manageMyGame) forControlEvents:UIControlEventTouchUpInside];
    PopoverView *popoverView = [[PopoverView alloc] init];
    [popoverView showAtPoint:point inView:self.view withContentView:popView];
}


-(void)refreshBottomView
{
    _countDownTime = _detailModel.time;
    //1 开枪中   2 今日10点  3即将开始 其它 抢光
    NSInteger type = _detailModel.status;
    if (type == 1) {
        _actionBtn.backgroundColor = [UIColor redColor];
        [_actionBtn setTitle:@"去抢购" forState:UIControlStateNormal];
        
        NSString *grabText = [NSString stringWithFormat:@"%ld人正在抢",(long)_detailModel.qcount];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:grabText];
        [str addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x61C6BE) range:NSMakeRange(0,grabText.length - 4)];
        _grabLabel.attributedText = str;
        
        [self startTimer:[NSNumber numberWithInteger:type]];
    }else if (type == 2){
        _actionBtn.backgroundColor = [UIColor redColor];
        [_actionBtn setTitle:@"今日10点" forState:UIControlStateNormal];
        
        _actionBtn.userInteractionEnabled = NO;
        
        [self startTimer:[NSNumber numberWithInteger:type]];
    }else if (type == 3){
        _actionBtn.backgroundColor = [UIColor whiteColor];
        _actionBtn.userInteractionEnabled = NO;
        [_actionBtn setTitle:@"即将开始" forState:UIControlStateNormal];
        [_actionBtn setTitleColor:UIColorFromRGB(0xD0D0D0) forState:UIControlStateNormal];
        
        _grabLabel.hidden = YES;
        _countDownLabel.hidden = YES;
        _timeLabel.hidden = NO;
        
        [self startTimer:[NSNumber numberWithInteger:_detailModel.status]];
    }else{
        _actionBtn.backgroundColor = [UIColor redColor];
        [_actionBtn setTitle:@"抢光了" forState:UIControlStateNormal];
        
        _grabLabel.hidden = YES;
        _countDownLabel.hidden = YES;
    }
}

-(void)startTimer:(NSNumber *)type
{
    _countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(handleCountDownTimer:) userInfo:type repeats:YES];
}

-(void)handleCountDownTimer:(NSTimer *)timer
{
    _countDownTime --;
    if (_countDownTime == 0) {
        [_countDownTimer invalidate];
    }
    NSString *text = @"";
    NSInteger type = [[timer userInfo] integerValue];
    switch (type) {
        case 3:
            text = [NSString stringWithFormat:@"%@后开抢",[BaseUtil mathTime:_countDownTime]];
            _timeLabel.text = text;
            break;
        default:
            text = [NSString stringWithFormat:@"剩余%@",[BaseUtil mathTime:_countDownTime]];
            _countDownLabel.text = text;
            break;
    }
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
