//
//  CalendarViewCell.m
//  cunqianguan
//
//  Created by 四三一八 on 15/3/3.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "CalendarViewCell.h"
#import "JTCircleView.h"

static NSString *kJTCalendarDaySelected = @"kJTCalendarDaySelected";
@implementation CalendarViewCell{
    JTCircleView *circleView;
    UILabel *textLabel;
    JTCircleView *dotView;
    
    BOOL isSelected;
    
    int cacheIsToday;
    NSString *cacheCurrentDateText;
    SignModel *_model;
}

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
    isSelected = NO;
    self.isOtherMonth = NO;
    
    circleView = [JTCircleView new];
    [self addSubview:circleView];
    circleView.hidden = YES;
    
    textLabel = [UILabel new];
    [self addSubview:textLabel];
    
    dotView = [JTCircleView new];
    [self addSubview:dotView];
    dotView.hidden = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didDaySelected:) name:kJTCalendarDaySelected object:nil];
}

-(void)loadCell:(SignModel *)model
{
    _model = model;
    textLabel.text = [NSString stringWithFormat:@"%.2ld",model.showday];
    [self setSelected:model.issign animated:YES];
}

- (void)layoutSubviews
{
    [self configureConstraintsForSubviews];
}


- (void)configureConstraintsForSubviews
{
    textLabel.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    textLabel.textAlignment = NSTextAlignmentCenter;
    
    CGFloat sizeCircle = MIN(self.frame.size.width, self.frame.size.height);
    CGFloat sizeDot = sizeCircle;
    
    sizeCircle = sizeCircle * 1.;
    sizeDot = sizeDot * 1./9.;
    
    sizeCircle = roundf(sizeCircle);
    sizeDot = roundf(sizeDot);
    
    circleView.frame = CGRectMake(0, 0, sizeCircle, sizeCircle);
    circleView.center = CGPointMake(self.frame.size.width / 2., self.frame.size.height / 2.);
    circleView.layer.cornerRadius = sizeCircle / 2.;
    circleView.layer.borderWidth = 1;
    circleView.layer.borderColor = [UIColor colorWithRed:71./256. green:217/256. blue:204/256. alpha:1.].CGColor;
    
    dotView.frame = CGRectMake(0, 0, sizeDot, sizeDot);
    dotView.center = CGPointMake(self.frame.size.width / 2., (self.frame.size.height / 2.) + sizeDot * 2.5);
    dotView.layer.cornerRadius = sizeDot / 2.;
}

- (void)setDate:(NSDate *)date
{
    static NSDateFormatter *dateFormatter;
//    if(!dateFormatter){
//        dateFormatter = [NSDateFormatter new];
//        dateFormatter.timeZone = self.calendarManager.calendarAppearance.calendar.timeZone;
//        [dateFormatter setDateFormat:@"dd"];
//    }
//    
//    self->_date = date;
//    
//    textLabel.text = [dateFormatter stringFromDate:date];
    
    cacheIsToday = -1;
    cacheCurrentDateText = nil;
}

- (void)didTouch:(BOOL)selected
{
    [self setSelected:selected animated:YES];
    //[self.calendarManager setCurrentDateSelected:self.date];
    
    //[self.calendarManager.dataSource calendarDidDateSelected:self.calendarManager date:self.date];
    
//    if(!self.isOtherMonth){
//        return;
//    }
    
//    NSInteger currentMonthIndex = [self monthIndexForDate:self.date];
//    NSInteger calendarMonthIndex = [self monthIndexForDate:self.calendarManager.currentDate];
//    
//    currentMonthIndex = currentMonthIndex % 12;
//    
//    if(currentMonthIndex == (calendarMonthIndex + 1) % 12){
//        [self.calendarManager loadNextMonth];
//    }
//    else if(currentMonthIndex == (calendarMonthIndex + 12 - 1) % 12){
//        [self.calendarManager loadPreviousMonth];
//    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if(isSelected == selected){
        animated = NO;
    }
    dotView.hidden = YES;
    isSelected = selected;
    
    circleView.transform = CGAffineTransformIdentity;
    CGAffineTransform tr = CGAffineTransformIdentity;
    CGFloat opacity = 1.;
    
    if(_model.issign){
           if(_model.comb){
                circleView.color = [UIColor colorWithRed:71./256. green:217/256. blue:204/256. alpha:1.];
                textLabel.textColor = [UIColor whiteColor];
                dotView.hidden = NO;
                dotView.color = [UIColor whiteColor];
            }else{
                circleView.color = [UIColor colorWithRed:71./256. green:217/256. blue:204/256. alpha:1.];
                textLabel.textColor = [UIColor blackColor];
                dotView.color = [UIColor whiteColor];
            }
    }else{
            textLabel.textColor = [UIColor blackColor];
            circleView.hidden = NO;
    }
    circleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
    tr = CGAffineTransformIdentity;
    
    if(animated){
        [UIView animateWithDuration:.3 animations:^{
            circleView.layer.opacity = opacity;
            circleView.transform = tr;
        }];
    }
    else{
        circleView.layer.opacity = opacity;
        circleView.transform = tr;
    }
}

- (void)setIsOtherMonth:(BOOL)isOtherMonth
{
    //self->_isOtherMonth = isOtherMonth;
    [self setSelected:isSelected animated:NO];
}

- (void)reloadData
{
    //dotView.hidden = ![self.calendarManager.dataSource calendarHaveEvent:self.calendarManager date:self.date];
    
    //BOOL selected = [self isSameDate:[self.calendarManager currentDateSelected]];
    //[self setSelected:selected animated:NO];
}

- (BOOL)isToday
{
    if(cacheIsToday == 0){
        return NO;
    }
    else if(cacheIsToday == 1){
        return YES;
    }
    else{
        if([self isSameDate:[NSDate date]]){
            cacheIsToday = 1;
            return YES;
        }
        else{
            cacheIsToday = 0;
            return NO;
        }
    }
}

- (BOOL)isSameDate:(NSDate *)date
{
//    static NSDateFormatter *dateFormatter;
//    if(!dateFormatter){
//        dateFormatter = [NSDateFormatter new];
//        dateFormatter.timeZone = self.calendarManager.calendarAppearance.calendar.timeZone;
//        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//    }
//    
//    if(!cacheCurrentDateText){
//        cacheCurrentDateText = [dateFormatter stringFromDate:self.date];
//    }
//    
//    NSString *dateText2 = [dateFormatter stringFromDate:date];
//    
//    if ([cacheCurrentDateText isEqualToString:dateText2]) {
//        return YES;
//    }
    
    return NO;
}
@end
