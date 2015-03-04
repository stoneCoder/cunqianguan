//
//  CalenderDayView.m
//  cunqianguan
//
//  Created by 四三一八 on 15/3/4.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "CalenderDayView.h"

@implementation CalenderDayView

static NSArray *cacheDaysOfWeeks;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(!self){
        return nil;
    }
    
    [self commonInit];
    
    return self;
}

- (void)commonInit
{
    for(NSString *day in [self daysOfWeek]){
        UILabel *view = [UILabel new];
        view.font = [UIFont systemFontOfSize:11];
        view.textColor = [UIColor colorWithRed:152./256. green:147./256. blue:157./256. alpha:1.];
        view.textAlignment = NSTextAlignmentCenter;
        view.text = day;
        view.backgroundColor = [UIColor clearColor];
        [self addSubview:view];
    }
    
    CGFloat x = 0;
    CGFloat width = self.frame.size.width / 7.;
    CGFloat height = self.frame.size.height;
    
    for(UIView *view in self.subviews){
        view.frame = CGRectMake(x, 0, width, height);
        x = CGRectGetMaxX(view.frame);
    }
    self.backgroundColor =  [UIColor colorWithRed:241./256. green:244./256. blue:242./256. alpha:1.];
}

- (NSArray *)daysOfWeek
{
    if(cacheDaysOfWeeks){
        return cacheDaysOfWeeks;
    }
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    NSMutableArray *days = [[dateFormatter standaloneWeekdaySymbols] mutableCopy];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSUInteger firstWeekday = (calendar.firstWeekday + 6) % 7; // Sunday == 1, Saturday == 7
    
    for(int i = 0; i < firstWeekday; ++i){
        id day = [days firstObject];
        [days removeObjectAtIndex:0];
        [days addObject:day];
    }
    
    
    for(NSInteger i = 0; i < days.count; ++i){
        NSString *day = days[i];
        [days replaceObjectAtIndex:i withObject:[[day uppercaseString] substringFromIndex:2]];
    }
    cacheDaysOfWeeks = days;
    return cacheDaysOfWeeks;
}

- (void)reloadAppearance
{
    for(int i = 0; i < self.subviews.count; ++i){
        UILabel *view = [self.subviews objectAtIndex:i];
        view.text = [[self daysOfWeek] objectAtIndex:i];
    }
}
@end
