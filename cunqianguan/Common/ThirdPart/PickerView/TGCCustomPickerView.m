//
//  TGCCustomPickerView.m
//  Chat
//
//  Created by 怡龙谷 on 14-11-6.
//  Copyright (c) 2014年 Huang Xiu Yong. All rights reserved.
//

#import "TGCCustomPickerView.h"

@interface TGCCustomPickerView () <UIPickerViewDataSource, UIPickerViewDelegate> {
    BOOL _isFinished;
}

@property (nonatomic, strong) UIView *pickerView;
@end

@implementation TGCCustomPickerView

- (id)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame andPickerViewType:kTGCPickerViewTypeDate andComponents:0];
}

- (id)initWithFrame:(CGRect)frame andPickerViewType:(enum kTGCPickerViewType)type andComponents:(NSUInteger)components {
    CGRect rect = frame;
    //rect.size.height = 200;
    self = [super initWithFrame:rect];
    if (self) {
        self.pickerViewType = type;
        self.components = components;
        [self _initUI];
    }
    return self;
}

- (void)_initUI {
    self.backgroundColor = [UIColor whiteColor];
    
    UIView *fengge = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 1)];
    fengge.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.8];
    UIButton *cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    [cancel setTitleColor:[UIColor colorWithRed:70./255. green:70./255. blue:70./255. alpha:1.] forState:UIControlStateNormal];
    cancel.titleLabel.font = [UIFont systemFontOfSize:13];
    [cancel sizeToFit];
    cancel.center = CGPointMake(40, 20);
    [cancel addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"完成" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:70./255. green:70./255. blue:70./255. alpha:1.] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    [button sizeToFit];
    button.center = CGPointMake(self.bounds.size.width - 40, 20);
    [button addTarget:self action:@selector(finish) forControlEvents:UIControlEventTouchUpInside];
    if (self.pickerViewType == kTGCPickerViewTypeCustom) {
        UIPickerView *dataPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40, self.bounds.size.width, 160)];
        dataPicker.dataSource = self;
        dataPicker.delegate = self;
        self.pickerView = dataPicker;
        [self addSubview:self.pickerView];
    }
    [self addSubview:fengge];
    [self addSubview:cancel];
    [self addSubview:button];
}

- (void)forDateShowingString {
    if ([self.pickerView isKindOfClass:[UIDatePicker class]]) {
        UIDatePicker *datePickerView = (UIDatePicker *)self.pickerView;
        NSString *age = [NSString stringWithFormat:@"%@", datePickerView.date];
        self.showingString = [age substringWithRange:NSMakeRange(0, 10)];
    }
}

#pragma mark -

- (void)forDataShowingStringWithRowsCount:(NSArray *)rows {
    if (rows.count == 0) {
        return;
    }
    NSString *string = [[NSString alloc] init];
    for (int i = 0; i < self.components; i++) {
        NSArray *array = [self.componentDics valueForKey:[NSString stringWithFormat:@"%d", i]];
        if (array.count != 0 && ((NSString *)rows[i]).integerValue < array.count) {
            NSString *rowCountString = rows[i];
            NSInteger rowCount = rowCountString.integerValue;
            if (i == 0) {
                string = array[rowCount];
            } else {
                string = [string stringByAppendingString:array[rowCount]];
            }
        }
    }
    self.showingString = string;
}

- (void)show {
    if (_visible) {
        return;
    }
    _visible = YES;
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(0, self.frame.origin.y - self.bounds.size.height, self.bounds.size.width, self.bounds.size.height);
    } completion:^(BOOL finished) {
        if (_pickerViewType == kTGCPickerViewTypeDate) {
            [self forDateShowingString];
        } else {
            NSMutableArray *array = [[NSMutableArray alloc] init];
            for (int i = 0; i < self.components; i++) {
                 [array addObject:@"0"];
            }
            [self forDataShowingStringWithRowsCount:array];
        }
        if (self.delegate && [self.delegate respondsToSelector:@selector(didShowPickerView:)]) {
            [self.delegate didShowPickerView:self.pickerView];
        }
    }];
}

- (void)dismiss {
    if (_visible == NO) {
        return;
    }
    _visible = NO;
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, self.bounds.size.width, self.bounds.size.height);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if (!_isFinished && self.delegate && [self.delegate respondsToSelector:@selector(didDismissPickerView)]) {
            [self.delegate didDismissPickerView];
        }
    }];
}

- (void)finish {
    _isFinished = YES;
    if (_pickerViewType == kTGCPickerViewTypeDate) {
        [self forDateShowingString];
    } else {
        UIPickerView *pickerView = (UIPickerView *)self.pickerView;
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (int i = 0; i < self.components; i++) {
            NSInteger rowCount = [pickerView selectedRowInComponent:i];
            [array addObject:[NSString stringWithFormat:@"%ld", (long)rowCount]];
        }
        [self forDataShowingStringWithRowsCount:array];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(didFinishPicker)]) {
        [self.delegate didFinishPicker];
    }
    [self dismiss];
}

- (void)configCustomPickerViewToDatePickerView:(UIDatePicker *)datePickerView {
    if (datePickerView == self.pickerView) {
        return;
    }
    [self.pickerView removeFromSuperview];
    self.pickerView = datePickerView;
    self.pickerView.frame = CGRectMake(0, 40, self.bounds.size.width, 160);
    [self addSubview:self.pickerView];
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return self.components;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSArray *array = [self.componentDics objectForKey:[NSString stringWithFormat:@"%ld", (long)component]];
    return array.count;
}

#pragma mark - UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSArray *array = [self.componentDics objectForKey:[NSString stringWithFormat:@"%ld", (long)component]];
    return array[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didPickerView:selectRow:inComponent:)]) {
        [self.delegate didPickerView:pickerView selectRow:row inComponent:component];
    }
}
@end
