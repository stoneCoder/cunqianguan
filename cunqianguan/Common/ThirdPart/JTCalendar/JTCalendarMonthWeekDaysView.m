//
//  JTCalendarMonthWeekDaysView.m
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import "JTCalendarMonthWeekDaysView.h"

@implementation JTCalendarMonthWeekDaysView

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

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
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
        
        view.font = self.calendarManager.calendarAppearance.weekDayTextFont;
        view.textColor = self.calendarManager.calendarAppearance.weekDayTextColor;
        view.textAlignment = NSTextAlignmentCenter;
        view.text = day;
        view.backgroundColor = [UIColor clearColor];
        [self addSubview:view];
    }
}

- (NSArray *)daysOfWeek
{
    if(cacheDaysOfWeeks){
        return cacheDaysOfWeeks;
    }
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    NSMutableArray *days = [[dateFormatter standaloneWeekdaySymbols] mutableCopy];

    NSCalendar *calendar = self.calendarManager.calendarAppearance.calendar;
    NSUInteger firstWeekday = (calendar.firstWeekday + 6) % 7; // Sunday == 1, Saturday == 7
            
    for(int i = 0; i < firstWeekday; ++i){
        id day = [days firstObject];
        [days removeObjectAtIndex:0];
        [days addObject:day];
    }
    
    switch(self.calendarManager.calendarAppearance.weekDayFormat){
        case JTCalendarWeekDayFormatSingle:
            for(NSInteger i = 0; i < days.count; ++i){
                NSString *day = days[i];
                [days replaceObjectAtIndex:i withObject:[[day uppercaseString] substringToIndex:1]];
            }
            break;
        case JTCalendarWeekDayFormatShort:
            for(NSInteger i = 0; i < days.count; ++i){
                NSString *day = days[i];
                [days replaceObjectAtIndex:i withObject:[[day uppercaseString] substringToIndex:3]];
            }
            break;
        case JTCalendarWeekDayFormatFull:
            for(NSInteger i = 0; i < days.count; ++i){
                NSString *day = days[i];
                [days replaceObjectAtIndex:i withObject:[day uppercaseString]];
            }
            break;
        case JTCalendarWeekDayFormatChShort:
            for(NSInteger i = 0; i < days.count; ++i){
                NSString *day = days[i];
                [days replaceObjectAtIndex:i withObject:[[day uppercaseString] substringFromIndex:2]];
            }
            break;
    }
    cacheDaysOfWeeks = days;
    return cacheDaysOfWeeks;
}

- (void)layoutSubviews
{
    CGFloat x = 0;
    CGFloat width = self.frame.size.width / 7.;
    CGFloat height = self.frame.size.height;
    
    for(UIView *view in self.subviews){
        view.frame = CGRectMake(x, 0, width, height);
        x = CGRectGetMaxX(view.frame);
    }
    self.backgroundColor =  self.calendarManager.calendarAppearance.weekDayBgColor;
}

+ (void)beforeReloadAppearance
{
    cacheDaysOfWeeks = nil;
}

- (void)reloadAppearance
{
    for(int i = 0; i < self.subviews.count; ++i){
        UILabel *view = [self.subviews objectAtIndex:i];
        
        view.font = self.calendarManager.calendarAppearance.weekDayTextFont;
        view.textColor = self.calendarManager.calendarAppearance.weekDayTextColor;
        
        view.text = [[self daysOfWeek] objectAtIndex:i];
    }
}

@end

