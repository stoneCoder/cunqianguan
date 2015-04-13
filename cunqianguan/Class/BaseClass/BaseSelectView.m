//
//  BaseSelectView.m
//  cunqianguan
//
//  Created by 四三一八 on 15/2/3.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "BaseSelectView.h"
#import "UIView+Borders.h"
#define BTN_HEIGTH 44
@implementation BaseSelectView
{
    UIView *_btnView;
    NSMutableArray *_btnViewArray;
    CGRect _animotionFrame;
    CGFloat _animotionHeight;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0. green:0. blue:0. alpha:0.3];
        self.hidden = YES;
        _btnViewArray = [NSMutableArray array];
        
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideView)]];
    }
    return self;
}

-(void)initView:(NSArray *)btnArray andVisiableY:(CGFloat)visiableY
{
    CGFloat width = self.frame.size.width;
    CGFloat heigth = [self calculateHeigthForRow:btnArray.count];
    _animotionHeight = heigth;
    _animotionFrame = CGRectMake(0, visiableY, width, 0);
    _btnView = [[UIView alloc] initWithFrame:CGRectMake(0, visiableY, width, 0)];
    [self createBtnWithArray:btnArray andRemaind:[self calculateNum:btnArray.count]];
    _btnView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_btnView];
}

-(void)createBtnWithArray:(NSArray *)btnArray andRemaind:(NSInteger)remainder
{
    CGFloat visiableX = 0,visiableY = 0,btnWidth = floor(_btnView.frame.size.width/3),btnHeight = 44;
    for (int i = 0; i < btnArray.count + remainder; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(visiableX, visiableY,btnWidth, btnHeight)];
        btn.backgroundColor = [UIColor whiteColor];
        btn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [btn addRightBorderWithWidth:0.5f andColor:UIColorFromRGB(0xececec)];
        [btn addBottomBorderWithHeight:0.5f andColor:UIColorFromRGB(0xececec)];

        if (i < btnArray.count) {
            [btn setTitle:btnArray[i] forState:UIControlStateNormal];
        }
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        btn.tag = i;
        
        CGRect tmpFrame = btn.frame;
        if (btn.frame.origin.x + btnWidth > _btnView.frame.size.width) {
            visiableY = btn.frame.origin.y + btnHeight;
            visiableX = 0;
        }
        tmpFrame.origin.x = visiableX;
        tmpFrame.origin.y = visiableY;
        btn.frame = tmpFrame;
        if (i < btnArray.count) {
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        }else{
            btn.userInteractionEnabled = NO;
        }
        [_btnView addSubview:btn];
        [_btnViewArray addObject:btn];
        visiableX = btn.frame.origin.x + btnWidth;
    }

}

-(void)showView
{
        [UIView animateWithDuration:0.25f delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            self.hidden = NO;
            _animotionFrame.size.height = _animotionHeight;
            _btnView.frame = _animotionFrame;
        } completion:^(BOOL finished) {
        }];
}

-(void)hideView
{
    [UIView animateWithDuration:0.25f  delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        _animotionFrame.size.height = 0;
        _btnView.frame = _animotionFrame;
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}

-(void)btnClick:(UIButton *)btn
{
    if (_selectIndex == btn.tag) {
        return;
    }
    [self setSelectIndex:btn.tag];
    [self hideView];
    if (_delegate && [_delegate respondsToSelector:@selector(selectBtn:)]) {
        [_delegate selectBtn:btn.tag];
    }
}

-(void)setSelectIndex:(NSInteger)selectIndex
{
    UIButton *oldBtn = _btnViewArray[_selectIndex];
    oldBtn.selected = NO;
    oldBtn.backgroundColor = [UIColor whiteColor];
    
    _selectIndex = selectIndex;
    UIButton *selectBtn = _btnViewArray[selectIndex];
    selectBtn.selected = YES;
    selectBtn.backgroundColor = UIColorFromRGB(0x22AC9D);
}

#pragma mark -- Private
-(CGFloat)calculateHeigthForRow:(NSInteger)count
{
    CGFloat rowHeigth,heigth = BTN_HEIGTH;
    if (count%3 > 0) {
        rowHeigth = heigth *(count/3 + 1);
    }else{
        rowHeigth = heigth*(count/3);
    }
    return rowHeigth;
}

-(int)calculateNum:(NSInteger)count
{
    int num = 0;
    if (count%3 > 0) {
        num = 3 - count%3;
    }
    return num;
}
@end
