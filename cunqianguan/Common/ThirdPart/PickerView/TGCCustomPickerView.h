//
//  TGCCustomPickerView.h
//  Chat
//
//  Created by 怡龙谷 on 14-11-6.
//  Copyright (c) 2014年 Huang Xiu Yong. All rights reserved.
//

#import <UIKit/UIKit.h>

enum kTGCPickerViewType {
    kTGCPickerViewTypeDate = 0,
    kTGCPickerViewTypeCustom = 1
};

@protocol TGCCustomPickerViewDelegate <NSObject>
@required
- (void)didPickerView:(UIPickerView *)pickerView selectRow:(NSInteger)row inComponent:(NSInteger)component;
@optional
- (void)didShowPickerView:(UIView *)pickerView;
- (void)didDismissPickerView;
- (void)didFinishPicker;
@end

@interface TGCCustomPickerView : UIView
@property (nonatomic, readonly) BOOL visible;
@property (nonatomic) enum kTGCPickerViewType pickerViewType;
@property (nonatomic) NSUInteger components;
@property (nonatomic, strong) NSMutableDictionary *componentDics; //value must be an array, key must be a integer with string like @"1".
@property (nonatomic, copy) NSString *showingString; //never set value directly. use 'forDataShowingStringWithRowsCount:'

@property (nonatomic, weak) id<TGCCustomPickerViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame andPickerViewType:(enum kTGCPickerViewType)type andComponents:(NSUInteger)components;

- (void)show;
- (void)dismiss;
- (void)configCustomPickerViewToDatePickerView:(UIDatePicker *)datePickerView;
- (void)forDataShowingStringWithRowsCount:(NSArray *)rows; //rows must be an array with string of integers like this @"1".
@end
