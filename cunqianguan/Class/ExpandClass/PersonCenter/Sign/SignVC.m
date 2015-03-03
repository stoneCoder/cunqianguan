//
//  SignVC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/2/9.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "SignVC.h"
#import "CalendarView.h"
#import "PersonConnect.h"
#import "BaseConnect.h"

#import "PersonInfo.h"
#import "SignDataModel.h"
static NSString *kJTCalendarDaySelected = @"kJTCalendarDaySelected";
@interface SignVC ()<JTCalendarDataSource>
{
    PersonInfo *_info;
    SignDataModel *_dataModel;
    CalendarView *_calendarView;
}

@end

@implementation SignVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _info = [PersonInfo sharedPersonInfo];
    [self setUpCalendar];
    [self setUpLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUpCalendar
{
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [flowLayout setSectionInset:UIEdgeInsetsMake(1, 1, 1, 1)];
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 2;
    
    _calendarView = [[CalendarView alloc] initWithFrame:_calendarContentView.frame collectionViewLayout:flowLayout];
    _calendarView.backgroundColor = [UIColor whiteColor];
    _calendarView.dataSource = _calendarView;
    _calendarView.delegate = _calendarView;
    [_calendarContentView addSubview:_calendarView];

}

-(void)setUpLabel
{
    _infoLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _infoLabel.numberOfLines = 0;
    
    NSString *infoText = @"每日在保鲜期网站或手机端签到可得积分。连续签到5天即可获得超值奖励！使用手机端签到任意一天，即可在获得超值奖励的同时获得额外奖励！期间如果中断，将会重新从第一天开始。";
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:infoText];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(19,15)];
    _infoLabel.attributedText = str;
}

-(IBAction)next:(id)sender
{
    
}

-(IBAction)previous:(id)sender
{
    
}

- (IBAction)signAction:(id)sender
{
    [self showHUD:ACTION_LOAD];
    [[PersonConnect sharedPersonConnect] signin:_info.userId success:^(id json) {
        [self hideAllHUD];
        NSDictionary *dic = (NSDictionary *)json;
        if ([BaseConnect isSucceeded:dic]) {
            [self loadData:_info.userId];
        }
    } failure:^(NSError *err) {
        [self hideAllHUD];
    }];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    CGRect frame = _calendarContentView.frame;
    _calendarView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    [self loadData:_info.userId];
}

-(void)viewWillDisappear:(BOOL)animated
{
    _calendarContentView.hidden = YES;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]  removeObserver:self];
}

-(void)loadData:(NSString *)userId
{
    [self showHUD:DATA_LOAD];
    [[PersonConnect sharedPersonConnect] getSignStatus:userId success:^(id json) {
        [self hideAllHUD];
        NSDictionary *dic = (NSDictionary *)json;
        if ([BaseConnect isSucceeded:dic]) {
            _dataModel = [[SignDataModel alloc] initWithDictionary:[dic objectForKey:@"data"] error:nil];
            if (_dataModel.logs.count > 0) {
                [_calendarView reloadDataWith:_dataModel.logs];
            }
        }
    } failure:^(NSError *err) {
        [self hideAllHUD];
    }];
}


#pragma mark - JTCalendarDataSource

- (BOOL)calendarHaveEvent:(JTCalendar *)calendar date:(NSDate *)date
{
    return (rand() % 10) == 1;
}

- (void)calendarDidDateSelected:(JTCalendar *)calendar date:(NSDate *)date
{
    NSLog(@"Date: %@", date);
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
