//
//  JTCalendarMenuMonthView.m
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import "JTCalendarMenuMonthView.h"

@interface JTCalendarMenuMonthView(){
    UILabel *textLabel;
}

@end

@implementation JTCalendarMenuMonthView

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
    {
        
        textLabel = [UILabel new];
        [self addSubview:textLabel];
        textLabel.textAlignment = NSTextAlignmentCenter;
    }
}

- (void)setMonthIndex:(NSInteger)monthIndex withCurrent:(NSDate *)current
{
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [NSDateFormatter new];
        dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        dateFormatter.timeZone = self.calendarManager.calendarAppearance.calendar.timeZone;
    }

    while(monthIndex <= 0){
        monthIndex += 12;
    }
    dateFormatter.dateFormat = @"YYYY年MM月";
    textLabel.text = [dateFormatter stringFromDate:current];
    //[[dateFormatter standaloneMonthSymbols][monthIndex - 1] capitalizedString];
}

- (void)layoutSubviews
{
    textLabel.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

- (void)reloadAppearance
{
    textLabel.textColor = self.calendarManager.calendarAppearance.menuMonthTextColor;
    textLabel.font = self.calendarManager.calendarAppearance.menuMonthTextFont;
}

@end
