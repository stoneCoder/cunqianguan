//
//  CalendarViewCell.m
//  cunqianguan
//
//  Created by 四三一八 on 15/3/3.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "CalendarViewCell.h"
#import "JTCircleView.h"
#import "BaseUtil.h"
static NSString *kJTCalendarDaySelected = @"kJTCalendarDaySelected";
@implementation CalendarViewCell{
    JTCircleView *circleView;
    UILabel *textLabel;
    JTCircleView *dotView;
    
    BOOL isSelected;
    
    int cacheIsToday;
    NSString *cacheCurrentDateText;
    SignModel *_model;
    NSDate *_nowDate;
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

-(void)loadCell:(SignModel *)model andNowDate:(NSDate *)date
{
    _model = model;
    _nowDate = date;
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
                dotView.hidden = NO;
                dotView.color = [UIColor whiteColor];
            }else{
                circleView.color = [UIColor whiteColor];
                textLabel.textColor = [UIColor blackColor];
            }
        if ([self isOtherMonth]) {
            textLabel.textColor = [UIColor colorWithRed:152./256. green:147./256. blue:157./256. alpha:1.];
        }
        circleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
        tr = CGAffineTransformIdentity;
    }else{
        if ([self isOtherMonth]) {
            textLabel.textColor = [UIColor colorWithRed:152./256. green:147./256. blue:157./256. alpha:1.];
        }else{
            textLabel.textColor = [UIColor blackColor];
        }
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

-(BOOL)isOtherMonth
{
    NSString *dateStr = [BaseUtil convertStringFromDate:_nowDate WithType:@"yyyy-MM"];
    NSString *nowDateStr = [BaseUtil convertStringFromDate:[NSDate dateWithTimeIntervalSince1970:_model.showdayios] WithType:@"yyyy-MM"];
    if ([dateStr isEqualToString:nowDateStr]) {
        return NO;
    }
    return YES;
}
@end
