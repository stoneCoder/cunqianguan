//
//  BaseSelectView.m
//  cunqianguan
//
//  Created by 四三一八 on 15/2/3.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "BaseSelectView.h"
#define BTN_HEIGTH 44
@implementation BaseSelectView
{
    UIView *_btnView;
    NSMutableArray *_btnViewArray;
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
    }
    return self;
}

-(void)initView:(NSArray *)btnArray andVisiableY:(CGFloat)visiableY
{
    CGFloat width = self.frame.size.width;
    CGFloat heigth = [self calculateHeigthForRow:btnArray.count];
    _btnView = [[UIView alloc] initWithFrame:CGRectMake(0, visiableY, width, heigth)];
    [self createBtnWithArray:btnArray];
    _btnView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_btnView];
}

-(void)createBtnWithArray:(NSArray *)btnArray
{
    CGFloat visiableX = 0,visiableY = 0,btnWidth = floor(_btnView.frame.size.width/3),btnHeight = 44;
    for (int i = 0; i < btnArray.count; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(visiableX, visiableY,btnWidth, btnHeight)];
        btn.backgroundColor = [UIColor whiteColor];
        btn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        btn.layer.borderWidth = 0.5;
        btn.layer.borderColor = UIColorFromRGB(0xececec).CGColor;
        [btn setTitle:btnArray[i] forState:UIControlStateNormal];
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
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_btnView addSubview:btn];
        [_btnViewArray addObject:btn];
        visiableX = btn.frame.origin.x + btnWidth;
    }

}

-(void)showView
{
    [UIView animateWithDuration:0.2 animations:^{
        self.hidden = NO;
    }];
}

-(void)hideView
{
    [UIView animateWithDuration:0.2 animations:^{
        self.hidden = YES;
    } completion:^(BOOL finished) {
        //[self removeFromSuperview];
    }];
    
//    if (_delegate && [_delegate respondsToSelector:@selector(popoverViewDidDismiss:)]) {
//        [_delegate popoverViewDidDismiss:self];
//    }
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
@end
