//
//  SignVC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/2/9.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "SignVC.h"
#import "CalendarView.h"
#import "CalenderDayView.h"

#import "PersonConnect.h"
#import "BaseConnect.h"
#import "BaseUtil.h"
#import "PersonInfo.h"
#import "SignDataModel.h"
static NSString *kJTCalendarDaySelected = @"kJTCalendarDaySelected";
@interface SignVC ()<JTCalendarDataSource>
{
    PersonInfo *_info;
    SignDataModel *_dataModel;
    CalendarView *_calendarView;
    CalenderDayView *_dayView;
    NSDate *_showDate;
}

@end

@implementation SignVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _info = [PersonInfo sharedPersonInfo];
    [self setUpCalendar];
    [self setUpLabel];
    [self setUpBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)setUpCalendar
{
    
    _dayView = [[CalenderDayView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    [_dayView reloadAppearance];
    [_calendarContentView addSubview:_dayView];
    
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [flowLayout setSectionInset:UIEdgeInsetsMake(1, 1, 1, 1)];
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 2;
    
    CGRect frame = _calendarContentView.frame;
    frame.origin.y = _dayView.frame.size.height + _dayView.frame.origin.y;
    _calendarView = [[CalendarView alloc] initWithFrame:frame collectionViewLayout:flowLayout];
    _calendarView.backgroundColor = [UIColor whiteColor];
    _calendarView.delegate = _calendarView;
    _calendarView.dataSource = _calendarView;
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

-(void)setUpBtn
{
    _actionBtn.layer.cornerRadius = 5.0f;
    _actionBtn.layer.masksToBounds = YES;
    [_actionBtn setBackgroundImage:[BaseUtil imageWithColor:UIColorFromRGB(0x2db8ad)] forState:UIControlStateNormal];
    [_actionBtn setBackgroundImage:[BaseUtil imageWithColor:UIColorFromRGB(0x179a90)] forState:UIControlStateHighlighted];
    
    if (_info.isSignToday) {
        [_actionBtn setTitle:@"今日已签到" forState:UIControlStateNormal];
        [_actionBtn setBackgroundColor:[UIColor grayColor]];
        _actionBtn.userInteractionEnabled = NO;
    }
}

-(IBAction)next:(id)sender
{
    [self loadDataWithTime:[self calculateDate:+1]];
}

-(IBAction)previous:(id)sender
{
    [self loadDataWithTime:[self calculateDate:-1]];
}

- (IBAction)signAction:(id)sender
{
    [self showHUD:ACTION_LOAD];
    [[PersonConnect sharedPersonConnect] signin:_info.userId success:^(id json) {
        [self hideAllHUD];
        NSDictionary *dic = (NSDictionary *)json;
        if ([BaseConnect isSucceeded:dic]) {
            [_actionBtn setTitle:@"今日已签到" forState:UIControlStateNormal];
            [_actionBtn setBackgroundColor:[UIColor grayColor]];
            _info.isSignToday = 1;
            [_info saveUserData];
            [self loadDataWithTime:[BaseUtil convertStringFromDate:[NSDate date] WithType:@"yyyy-MM"]];
        }
    } failure:^(NSError *err) {
        [self hideAllHUD];
    }];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    CGRect viewFrame = _calendarView.frame;
    CGRect frame = _calendarContentView.frame;
    viewFrame.size.width = frame.size.width;
    viewFrame.size.height = frame.size.height - _dayView.frame.size.height;
    _calendarView.frame = viewFrame;
    [self loadDataWithTime:[BaseUtil convertStringFromDate:[NSDate date] WithType:@"yyyy-MM"]];
}

-(void)viewWillDisappear:(BOOL)animated
{
    _calendarContentView.hidden = YES;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]  removeObserver:self];
}

-(void)loadDataWithTime:(NSString *)ptime
{
    [self showHUD:DATA_LOAD];
    [[PersonConnect sharedPersonConnect] getSignStatus:_info.userId withTime:ptime  success:^(id json) {
        [self hideAllHUD];
        NSDictionary *dic = (NSDictionary *)json;
        if ([BaseConnect isSucceeded:dic]) {
            _dataModel = [[SignDataModel alloc] initWithDictionary:[dic objectForKey:@"data"] error:nil];
            if (_dataModel.logs.count > 0) {
                _showDate = [BaseUtil convertDateFromString:_dataModel.ptime WithType:@"yyyy-MM"];
                [_calendarView reloadDataWith:_dataModel.logs andNowDate:_showDate];
                NSArray *times = [_dataModel.ptime componentsSeparatedByString:@"-"];
                _monthLabel.text = [NSString stringWithFormat:@"%@年%@月",times[0],times[1]];
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

#pragma mark - Private
-(NSString *)calculateDate:(NSInteger)month
{
    if (!_showDate) {
        _showDate = [NSDate date];
    }
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = nil;
    comps = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:_showDate];
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    [adcomps setYear:0];
    [adcomps setMonth:month];
    [adcomps setDay:0];
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:_showDate options:0];
    _showDate = newdate;
    return [BaseUtil convertStringFromDate:newdate WithType:@"yyyy-MM"];
}
@end
