//
//  SignVC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/2/9.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "SignVC.h"

static NSString *kJTCalendarDaySelected = @"kJTCalendarDaySelected";
@interface SignVC ()<JTCalendarDataSource>
{
    JTCalendar *_calendar;
}

@end

@implementation SignVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setUpCalendar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUpCalendar
{
    _calendar = [JTCalendar new];
    _calendar.calendarAppearance.calendar.firstWeekday = 1; // Sunday == 1, Saturday == 7
    _calendar.calendarAppearance.dayCircleRatio = 9. / 10.;
    _calendar.calendarAppearance.ratioContentMenu = 1.;
    
    [_calendar setMonthLabel:_monthLabel];
    self.calendarContentView.scrollEnabled = NO;
    [_calendar setContentView:self.calendarContentView];
    [_calendar setDataSource:self];
}

-(IBAction)next:(id)sender
{
    [_calendar loadNextMonth];
}

-(IBAction)previous:(id)sender
{
    [_calendar loadPreviousMonth];
}

- (IBAction)signAction:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kJTCalendarDaySelected object:[NSDate new]];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [_calendar reloadData];
}

-(void)viewWillDisappear:(BOOL)animated
{
    _calendarContentView.hidden = YES;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]  removeObserver:self];
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
