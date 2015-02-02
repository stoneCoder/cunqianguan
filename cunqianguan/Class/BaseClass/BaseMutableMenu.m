//
//  BaseMutableMenu.m
//  cunqianguan
//
//  Created by 四三一八 on 15/2/2.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "BaseMutableMenu.h"

#define LEFT_BTN_WIDTH 88
#define LEFT_BTN_HEIGHT 44
#define BTN_SPACING 10
@implementation BaseMutableMenu
{
    NSDictionary *_dataDic;
    NSArray *_tableBtnData;
    NSMutableArray *_btnViewArray;
    TouchPropagatedScrollView *_scrollView;
    UIView *_btnView;
    UITableView *_btnTableView;
    CGFloat _cellHeight;
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
        //[self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideView)]];
        self.hidden = YES;
        _btnViewArray = [NSMutableArray array];
    }
    return self;
}

-(void)initScrollView:(NSDictionary *)scrollMenuDic WithDirectionType:(NSInteger)directionType
{
    _dataDic = scrollMenuDic;
    NSArray *keyArray = [scrollMenuDic allKeys];
    _scrollView = [[TouchPropagatedScrollView alloc] initWithFrame:CGRectMake(0, 0, LEFT_BTN_WIDTH, self.frame.size.height)];
    [_scrollView setDirectionType:directionType];
    [_scrollView setIsShowSelectBackgroundColor:YES];
    [_scrollView setShowsVerticalScrollIndicator:NO];
    [_scrollView setContentSize:CGSizeMake(LEFT_BTN_WIDTH, LEFT_BTN_HEIGHT * [scrollMenuDic count])];
    [_scrollView setItems:keyArray isShowLine:YES];
    _scrollView.segmentDelegate = self;
    [self addSubview:_scrollView];
    
    [self initBtnTable:[scrollMenuDic objectForKey:[keyArray firstObject]]];
}

-(void)initBtnTable:(NSArray *)tableData
{
    _tableBtnData = tableData;
    CGRect frame = _scrollView.frame;
    CGFloat btnViewWidth = self.frame.size.width - frame.size.width;
    _btnTableView = [[UITableView alloc] initWithFrame:CGRectMake(frame.size.width, 0, btnViewWidth, self.frame.size.height) style:UITableViewStyleGrouped];
    _btnTableView.delegate = self;
    _btnTableView.dataSource = self;
    _btnTableView.scrollEnabled = NO;
    [self addSubview:_btnTableView];
    [_btnTableView reloadData];
}

-(void)initBtnView:(NSArray *)btnArray WithHeigth:(CGFloat)heigth
{
    CGRect frame = _scrollView.frame;
    CGFloat btnViewWidth = self.frame.size.width - frame.size.width;
    _btnView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,btnViewWidth, heigth)];
    _btnView.backgroundColor = [UIColor whiteColor];
    
    CGFloat visiableX = 10,visiableY = 10,spaceNum = 10,btnWidth = (btnViewWidth - 40)/3,btnHeight = 44;
    for (int i = 0; i < btnArray.count; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(visiableX, visiableY,btnWidth, btnHeight)];
        btn.backgroundColor = UIColorFromRGB(0XECECEC);
        btn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [btn setTitle:btnArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        btn.tag = i;
        
        CGRect tmpFrame = btn.frame;
        if (btn.frame.origin.x + btnWidth >= btnViewWidth) {
            visiableY = btn.frame.origin.y + btnHeight + spaceNum;
            visiableX = spaceNum;
        }
        tmpFrame.origin.x = visiableX;
        tmpFrame.origin.y = visiableY;
        btn.frame = tmpFrame;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_btnView addSubview:btn];
        visiableX = btn.frame.origin.x + btnWidth + spaceNum;
    }
}

-(void)btnClick:(UIButton *)btn
{
    if (_selectIndex >= _btnViewArray.count) {
        return;
    }
    UIButton *oldBtn = [_btnViewArray objectAtIndex:_selectIndex];
    oldBtn.selected = NO;
    oldBtn.backgroundColor = UIColorFromRGB(0xececec);
    
  
    _selectIndex = btn.tag;
    btn.selected = YES;
    btn.backgroundColor = UIColorFromRGB(0x40D0C2);
}

-(void)showView
{
    [UIView animateWithDuration:0.25 animations:^{
        self.hidden = NO;
    }];
}

-(void)hideView
{
    [UIView animateWithDuration:0.25 animations:^{
            self.hidden = YES;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
    if (_delegate && [_delegate respondsToSelector:@selector(popoverViewDidDismiss:)]) {
        [_delegate popoverViewDidDismiss:self];
    }
}

-(void)selectTitle:(NSString *)title
{
     _selectIndex = 0;
     //[self intiBtnView:[_dataDic objectForKey:title]];
}

-(void)selectIndex:(NSInteger)index
{
    
}

#pragma mark -- UITableViewDelegate && UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_tableBtnData count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [_tableBtnData[section] allKeys][0];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat heigth = LEFT_BTN_HEIGHT + BTN_SPACING;
    NSArray *btnArray = [_tableBtnData[indexPath.section] objectForKey:[_tableBtnData[indexPath.section] allKeys][0]];
    NSInteger count = btnArray.count;
    if (count%3 > 0) {
        CGFloat rowHeigth = heigth *(count/3 + 1) + BTN_SPACING;
        _cellHeight = rowHeigth;
        return rowHeigth;
    }
    CGFloat rowHeigth = heigth*(count/3) + BTN_SPACING;
    _cellHeight = rowHeigth;
    return rowHeigth;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *CellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
    }
    
    [self initBtnView:[_tableBtnData[indexPath.section] objectForKey:[_tableBtnData[indexPath.section] allKeys][0]] WithHeigth:_cellHeight];
    [cell.contentView addSubview:_btnView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


//-(UIView*)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
//    [super hitTest:point withEvent:event];
//    NSLog(@"======%@",NSStringFromCGPoint(point));
//    if (CGRectContainsPoint(CGRectMake(-6, -6, 36, 36), point)) {
//        return self;
//    }
//    return nil;
//}
@end
