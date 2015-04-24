//
//  MsgInfoCell.m
//  cunqianguan
//
//  Created by 四三一八 on 15/4/23.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "MsgInfoCell.h"
#import "BaseUtil.h"
@implementation MsgInfoCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
#pragma mark  修复IOS7 autolayout报错
        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        self.contentView.backgroundColor = UIColorFromRGB(0xececec);
        [self setUpView];
    }
    return self;
}


-(void)setUpView
{
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.borderWidth = 1.0f;
    bgView.layer.borderColor = UIColorFromRGB(0xe6e6e6).CGColor;
    bgView.layer.cornerRadius = 3.0f;
    bgView.layer.masksToBounds = YES;
    [self.contentView addSubview:bgView];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).with.offset(12);
        make.left.mas_equalTo(self.contentView).with.offset(8);
        make.bottom.mas_equalTo(self.contentView);
        make.right.mas_equalTo(self.contentView).with.offset(-8);
    }];
    
//    _tipImageView = [[UIImageView alloc] init];
//    [bgView addSubview:_tipImageView];
//    
//    [_tipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(bgView).with.offset(5);
//        make.left.mas_equalTo(bgView).with.offset(10);
//        //make.width.equalTo(@(44));
//        //make.height.equalTo(@(28));
//    }];
    
    _tipButton = [[UIButton alloc] init];
    _tipButton.titleLabel.font = [UIFont boldSystemFontOfSize:13.0f];
    _tipButton.userInteractionEnabled = NO;
    _tipButton.layer.cornerRadius = 2.0f;
    _tipButton.layer.masksToBounds = YES;
    [bgView addSubview:_tipButton];
    
    [_tipButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bgView).with.offset(10);
        make.left.mas_equalTo(bgView).with.offset(10);
        make.width.equalTo(@(44));
        make.height.equalTo(@(23));
    }];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textColor = UIColorFromRGB(0x3c3c3c);
    _titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [bgView addSubview:_titleLabel];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_tipButton.mas_right).with.offset(10);
        make.centerY.mas_equalTo(_tipButton);
    }];
    
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.backgroundColor = [UIColor clearColor];
    _timeLabel.textColor = UIColorFromRGB(0x969696);
    _timeLabel.font = [UIFont systemFontOfSize:11.0f];
    [bgView addSubview:_timeLabel];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bgView).with.offset(5);
        make.right.mas_equalTo(bgView).with.offset(-10);
        make.centerY.mas_equalTo(_titleLabel);
    }];
    
    _separatorView = [[UIView alloc] init];
    _separatorView.backgroundColor = UIColorFromRGB(0xe6e6e6);
    [bgView addSubview:_separatorView];
    
    [_separatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(0.5));
        make.left.mas_equalTo(bgView).with.offset(12);
        make.right.mas_equalTo(bgView).with.offset(-12);
        make.top.mas_equalTo(bgView).with.offset(38);
    }];
    
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.backgroundColor = [UIColor clearColor];
    _contentLabel.textColor = UIColorFromRGB(0x666666);
    _contentLabel.font = [UIFont systemFontOfSize:13.0f];
    _contentLabel.numberOfLines = 0;
    _contentLabel.lineBreakMode = NSLineBreakByCharWrapping;
    [bgView addSubview:_contentLabel];
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_separatorView.mas_bottom).with.offset(15.5);
        make.left.mas_equalTo(bgView).with.offset(10);
        make.right.mas_equalTo(bgView).with.offset(-10);
        make.bottom.mas_equalTo(bgView).with.offset(-16);
    }];
}


-(void)loadCell:(MsgModel *)model
{
    if (model.types == 0) {
        //_tipImageView.image = [UIImage imageNamed:@"msg_tip_noti"];
        _tipButton.backgroundColor = UIColorFromRGB(0x5ccdf2);
        [_tipButton setTitle:@"通知" forState:UIControlStateNormal];
    }else if (model.types == 1) {
        //_tipImageView.image = [UIImage imageNamed:@"msg_tip_post"];
        _tipButton.backgroundColor = UIColorFromRGB(0xf28282);
        [_tipButton setTitle:@"公告" forState:UIControlStateNormal];
    }
    _titleLabel.text = [self calculateStr:model.title];
    _timeLabel.text = [self calculateTime:model.addtime_date andNowDate:nil];
    _contentLabel.text = model.contents;
}

#pragma mark -- Private
-(NSString *)calculateStr:(NSString *)title
{
    if ([title rangeOfString:@"："].location != NSNotFound) {
        title = [title componentsSeparatedByString:@"："][1];
    }
    return title;
}

-(NSString *)calculateTime:(NSString *)timeStr andNowDate:(NSString *)date
{
    //2015-04-02 10:39:13  2014-04-02  今天 显示时间
    NSDate *nowDate = [NSDate date];
    NSString *nowDateStr =  [[nowDate description] substringToIndex:10];
    NSString *nowYearStr =  [[nowDate description] substringToIndex:4];
    
    NSDate *showDate = [BaseUtil convertDateFromString:timeStr WithType:@"yyyy-MM-dd HH:mm:ss"];
    NSString *showDateStr =  [timeStr substringToIndex:10];
    NSDateComponents *showDateComponent = [self componentsWithDate:showDate];
    NSInteger showYear = [showDateComponent year];
    NSInteger showMonth = [showDateComponent month];
    NSInteger showDay = [showDateComponent day];
    if ([nowYearStr integerValue] < showYear) {
        //小于今年显示年月日
        return showDateStr;
    }else if ([nowYearStr integerValue] == showYear && ![nowDateStr isEqualToString:showDateStr]){
       //等于今年 显示月
        return [NSString stringWithFormat:@"%ld-%ld",(long)showMonth,(long)showDay];
    }else if([nowDateStr isEqualToString:showDateStr]){
        //今天 显示时间
        return [timeStr substringFromIndex:timeStr.length - 9];
    }
    return nil;
}

-(NSDateComponents *)componentsWithDate:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    return [calendar components:unitFlags fromDate:date];
}


@end
