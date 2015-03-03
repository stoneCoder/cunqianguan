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

    circleView = [JTCircleView new];
    [self addSubview:circleView];
    //circleView.hidden = YES;
    
    textLabel = [UILabel new];
    [self addSubview:textLabel];
    
    dotView = [JTCircleView new];
    [self addSubview:dotView];
    dotView.hidden = YES;
    
    [self configureConstraintsForSubviews];
}

-(void)loadCell:(SignModel *)model
{
    _model = model;
    textLabel.text = [NSString stringWithFormat:@"%.2ld",(long)model.showday];
    [self setSelected:model.issign animated:YES];
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
    
    //选中
    if(_model.issign){
        //连续选中
           if(_model.comb){
                circleView.color = [UIColor colorWithRed:71./256. green:217/256. blue:204/256. alpha:1.];
                textLabel.textColor = [UIColor whiteColor];
                //dotView.hidden = NO;
                dotView.color = [UIColor whiteColor];
            }else{
                circleView.color = [UIColor whiteColor];
                textLabel.textColor = [UIColor blackColor];
            }
        circleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
        tr = CGAffineTransformIdentity;
    }else{
        textLabel.textColor = [UIColor blackColor];
        opacity = 0.;
    }
    
    
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
