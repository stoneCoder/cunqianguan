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
    self.contentView.backgroundColor = UIColorFromRGB(0x58ded4);
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
            
            _nameLabel.text = info.username;
            [_headImageView sd_setImageWithURL:[NSURL URLWithString:info.photo] placeholderImage:[UIImage imageNamed:@"default_person"]  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                _headImageView.image = [BaseUtil imageWithImage:image scaledToSize:_headImageView.frame.size];
            }];
            _collectLabel.text = [NSString stringWithFormat:@"%ld",(long)info.collectionCount];
            _msgLabel.text = [NSString stringWithFormat:@"%ld",(long)info.messageCount];
            _vipImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"vip_0%ld",(long)info.level]];
            
            CGRect frame = _progressView.frame;
            CGFloat width = (CGFloat)info.userExp/(CGFloat)info.nextUserExp*self.frame.size.width;
            _progressView.frame = CGRectMake(frame.origin.x, frame.origin.y, width, frame.size.height);

            _collectLabel.hidden = NO;
            _msgLabel.hidden = NO;
            _vipImage.hidden = NO;
        } failure:^(id json) {
            
        }];
    }else{
        _nameLabel.text = @"请登录";
        _collectLabel.hidden = YES;
        _msgLabel.hidden = YES;
        _vipImage.hidden = YES;
    }
    
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
