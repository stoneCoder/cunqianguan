//
//  PersonHeaderView.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/24.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "PersonHeaderView.h"
#import "BaseUtil.h"
@implementation PersonHeaderView
{
    PopTipView *_popTipView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(PersonHeaderView *)headerView
{
    NSArray* nibs = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
    PersonHeaderView *personHeaderView = nil;
    if ([nibs count]) {
        personHeaderView = [nibs objectAtIndex:0];
        [personHeaderView setUpView];
    }
    return personHeaderView;
}

-(void)setUpView
{
    self.contentView.backgroundColor = UIColorFromRGB(0x32DACD);
    _headBgView.layer.cornerRadius  = _headBgView.frame.size.width/2;
    _headBgView.clipsToBounds = YES;
    _headBgView.layer.borderWidth = 3;
    _headBgView.layer.borderColor = UIColorFromRGB(0x31b6ac).CGColor;
    
    _headImageView.layer.cornerRadius = _headImageView.frame.size.width/2;
    _headImageView.clipsToBounds = YES;
    _headImageView.layer.borderWidth = 3;
    _headImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    
    _headImageView.userInteractionEnabled = YES;
    [_headImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(updateInfo:)]];
    
    _pointImageView.layer.cornerRadius = _pointImageView.frame.size.width/2;
    _pointImageView.layer.masksToBounds = YES;
    
    _progressBgView.backgroundColor = UIColorFromRGB(0x3CD3C8);
    _progressView.backgroundColor = UIColorFromRGB(0x29AEA4);
}

-(void)loadView:(PersonInfo *)info
{
    if (info.userId) {
        [info getAvaterWithId:info.userId success:^(id json) {
            [info saveUserData];
        } failure:^(id json) {
            
        }];
        
        _nameLabel.text = info.username;
        [_headImageView sd_setImageWithURL:[NSURL URLWithString:info.photo] placeholderImage:[UIImage imageNamed:@"default_person"]  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            _headImageView.image = [BaseUtil imageWithImage:image scaledToSize:_headImageView.frame.size];
        }];
        _collectLabel.text = [NSString stringWithFormat:@"%ld",(long)info.collectionCount];
        _msgLabel.text = [NSString stringWithFormat:@"%ld",(long)info.messageCount];
        _vipImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"vip_0%ld",(long)info.level]];
        
        CGRect frame = _progressView.frame;
        CGFloat width = (CGFloat)info.userExp/(CGFloat)info.nextUserExp*SCREEN_WIDTH;
        _progressView.frame = CGRectMake(frame.origin.x, frame.origin.y, width, frame.size.height);
        
        _progressView.hidden = NO;
        _collectLabel.hidden = NO;
        _msgLabel.hidden = NO;
        _vipImage.hidden = NO;
        
        [self showTipView:_progressView.frame andInfo:info];
    }else{
        _nameLabel.text = @"请登录";
        _collectLabel.hidden = YES;
        _msgLabel.hidden = YES;
        _vipImage.hidden = YES;
        _popTipView.hidden = YES;
        _progressView.hidden = YES;
        [_headImageView setImage:[UIImage imageNamed:@"default_person"]];
    }
}

-(void)showTipView:(CGRect)frame andInfo:(PersonInfo *)info
{
    CGFloat height = 20.0f;
    UIFont *font = [UIFont systemFontOfSize:12.0f];
    NSString *str = [NSString stringWithFormat:@"%ld/%ld",(long)info.userExp,(long)info.nextUserExp];
    CGFloat width = [BaseUtil getWidthByString:str font:font allheight:height andMaxWidth:150];
    if (!_popTipView) {
        _popTipView = [[PopTipView alloc] initWithFrame:CGRectMake(0, 0, width + 10, height)];
    }
    _popTipView.hidden = NO;
    [_popTipView loadViewWith:str];
    CGFloat visiableX;
    if (frame.size.width < width/2) {
        visiableX = width/2 + frame.size.width;
    }else{
        visiableX = frame.size.width - width/2;
    }
    [_popTipView setCenter:CGPointMake(visiableX, frame.origin.y - _popTipView.frame.size.height/2)];
    [self addSubview:_popTipView];
}

- (IBAction)btnAction:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    if (_delegate && [_delegate respondsToSelector:@selector(btnAction:)]) {
        [_delegate btnAction:btn.tag];
    }
}

-(void)updateInfo:(UITapGestureRecognizer *)tap
{
    if (_delegate && [_delegate respondsToSelector:@selector(tapHeadImage)]) {
        [_delegate tapHeadImage];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

@end
