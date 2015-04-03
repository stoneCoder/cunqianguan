//
//  BaseMutableMenu.m
//  cunqianguan
//
//  Created by 四三一八 on 15/2/2.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "BaseMutableMenu.h"

#define LEFT_BTN_WIDTH 88
#define LEFT_BTN_HEIGHT 52
#define BTN_HEIGHT 30
#define BTN_SPACING 15

#import "BaseUtil.h"
#import "BaseConnect.h"
#import "MongoConnect.h"
#import "CateModel.h"
@implementation BaseMutableMenu
{
    NSDictionary *_dataDic;
    NSArray *_tableBtnData;
    NSMutableArray *_btnViewArray;
    TouchPropagatedScrollView *_scrollView;
    UIView *_btnView;
    UITableView *_btnTableView;
    CGFloat _cellHeight;
    MutableButton *_selectBtn;
    NSMutableArray *_menuIdArray;
    NSString *_parentId;
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
        self.backgroundColor = UIColorFromRGB(0xc8c8c8);
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideView:)]];
        self.hidden = YES;
        _btnViewArray = [NSMutableArray array];
    }
    return self;
}

-(void)initScrollViewWithDirectionType:(NSInteger)directionType
{
    NSArray *array = SELECT_ARRAY;
    NSMutableArray *menuArray = [NSMutableArray arrayWithArray:array];
    [menuArray removeObjectAtIndex:0];
    
    NSArray *idArray = SELECT_ID;
    _menuIdArray = [NSMutableArray arrayWithArray:idArray];
    [_menuIdArray removeObjectAtIndex:0];
    
    CGFloat height = LEFT_BTN_HEIGHT * [menuArray count];
    _scrollView = [[TouchPropagatedScrollView alloc] initWithFrame:CGRectMake(0, 0, LEFT_BTN_WIDTH, height)];
    _scrollView.backgroundColor = UIColorFromRGB(0xf0f0f0);
    [_scrollView setDirectionType:directionType];
    [_scrollView setIsShowSelectBackgroundColor:YES];
    [_scrollView setIsBorderStyle:YES];
    [_scrollView setShowsVerticalScrollIndicator:NO];
    [_scrollView setContentSize:CGSizeMake(LEFT_BTN_WIDTH, height)];
    [_scrollView setItems:menuArray isShowLine:YES];
    _scrollView.segmentDelegate = self;
    [self addSubview:_scrollView];
    [self initBtnTable];
}

-(void)initBtnTable
{
    CGRect frame = _scrollView.frame;
    CGFloat btnViewWidth = self.frame.size.width - frame.size.width;
    _btnTableView = [[UITableView alloc] initWithFrame:CGRectMake(frame.size.width, 0, btnViewWidth, self.frame.size.height) style:UITableViewStylePlain];
    _btnTableView.delegate = self;
    _btnTableView.dataSource = self;
    _btnTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _btnTableView.backgroundColor = [UIColor whiteColor];
    _btnTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
    _btnTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
//    _btnTableView.layer.borderWidth = 1.0f;
//    _btnTableView.layer.borderColor = UIColorFromRGB(0xC7C7C7).CGColor;
    [self addSubview:_btnTableView];
    
    
    [self loadTableData:_menuIdArray[0]];
}

-(void)loadTableData:(NSString *)parentId
{
    _parentId = parentId;
    [self showHUD:DATA_LOAD];
    [[MongoConnect sharedMongoConnect] getCateIndexById:parentId success:^(id json) {
        [self hideAllHUD];
        NSDictionary *dic = (NSDictionary *)json;
        if ([BaseConnect isSucceeded:dic]) {
            _tableBtnData = [dic objectForKey:@"data"];
            [_btnTableView reloadData];
        }
    } failure:^(NSError *err) {
        [self hideAllHUD];
    }];
}


-(void)initBtnView:(NSArray *)btnArray WithHeigth:(CGFloat)heigth ForSection:(NSInteger)section
{
    CGRect frame = _scrollView.frame;
    CGFloat btnViewWidth = self.frame.size.width - frame.size.width;
    _btnView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,btnViewWidth, heigth)];
    _btnView.backgroundColor = [UIColor whiteColor];
    if (_btnView) {
        [_btnView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    
    CGFloat visiableX = BTN_SPACING,visiableY = BTN_SPACING,spaceNum = BTN_SPACING,btnWidth = (btnViewWidth - BTN_SPACING*4)/3,btnHeight = BTN_HEIGHT;
    for (int i = 0; i < btnArray.count; i++) {
        CateModel *model = btnArray[i];
        MutableButton *btn = [[MutableButton alloc] initWithFrame:CGRectMake(visiableX, visiableY,btnWidth, btnHeight)];
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:12.0f];
        btn.titleLabel.numberOfLines = 0;
        btn.titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
        [btn setTitle:model.gname forState:UIControlStateNormal];
        btn.tag = [model.gid integerValue];
        btn.parentId = [_parentId integerValue];
        
        [btn setTitleColor:UIColorFromRGB(0x6f6f6f) forState:UIControlStateNormal];
        [btn setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateSelected];
        [btn setBackgroundImage:[BaseUtil imageWithColor:UIColorFromRGB(0xf0f0f0)] forState:UIControlStateNormal];
        [btn setBackgroundImage:[BaseUtil imageWithColor:UIColorFromRGB(0x50d6cc)] forState:UIControlStateSelected];
        
        btn.layer.borderWidth = 1.0f;
        btn.layer.borderColor = UIColorFromRGB(0xc3c3c3).CGColor;
        btn.layer.cornerRadius = 5.0f;
        btn.layer.masksToBounds = YES;
        
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:section];
        btn.indexPath = indexPath;
        
        CGRect tmpFrame = btn.frame;
        if (btn.frame.origin.x + btnWidth >= btnViewWidth) {
            visiableY = btn.frame.origin.y + btnHeight + spaceNum;
            visiableX = spaceNum;
        }
        tmpFrame.origin.x = visiableX;
        tmpFrame.origin.y = visiableY;
        btn.frame = tmpFrame;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        if ([_selectBtn.indexPath isEqual:indexPath] && _selectBtn.parentId == [_parentId integerValue]) {
            btn.selected = YES;
            btn.backgroundColor = UIColorFromRGB(0x40D0C2);
        }
        [_btnView addSubview:btn];
        [_btnViewArray addObject:btn];
        visiableX = btn.frame.origin.x + btnWidth + spaceNum;
    }
}

-(void)btnClick:(MutableButton *)btn
{
    if ([_selectBtn.indexPath isEqual:btn.indexPath] && _selectBtn.parentId == [_parentId integerValue]) {
        return;
    }
    _selectBtn.selected = NO;
    _selectBtn.layer.borderColor = UIColorFromRGB(0xc3c3c3).CGColor;
    
    _selectBtn = btn;
    btn.selected = YES;
    btn.layer.borderColor = UIColorFromRGB(0x1b8e8b).CGColor;
    
    if (_delegate && [_delegate respondsToSelector:@selector(clickAction:)]) {
        [_delegate clickAction:btn];
    }
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
        //[self removeFromSuperview];
    }];
    
    if (_delegate && [_delegate respondsToSelector:@selector(popoverViewDidDismiss:)]) {
        [_delegate popoverViewDidDismiss:self];
    }
}

-(void)hideView:(UITapGestureRecognizer *)tap
{
#pragma mark  手势事件传递
    UIView *view = [self hitTest:[tap locationInView:self] withEvent:UIEventTypeTouches];
    if ([view isKindOfClass:[UITableView class]]) {
        return;
    }else if ([view isKindOfClass:[TouchPropagatedScrollView class]]){
        return;
    }
}

-(void)selectTitle:(NSString *)title
{
//    _selectBtn = nil;
//     _tableBtnData = [_dataDic objectForKey:title];
//    [_btnTableView reloadData];
}

-(void)selectIndex:(NSInteger)index
{
    //_selectBtn = nil;
    [_scrollView setSelectIndex:index];
    [self loadTableData:_menuIdArray[index]];
}

//-(UIView*)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
//    CGPoint hitPoint = [_btnTableView convertPoint:point fromView:self];
//    if ([_btnTableView pointInside:hitPoint withEvent:event])
//    {
//        return _btnTableView;
//    }
//    hitPoint = [_scrollView convertPoint:point fromView:self];
//    if ([_scrollView pointInside:hitPoint withEvent:event]){
//        return _scrollView;
//    }
//    return [super hitTest:point withEvent:event];
//}

#pragma mark -- UITableViewDelegate && UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_tableBtnData count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _btnTableView.frame.size.width, 40)];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(20, 18, _btnTableView.frame.size.width - 20, 13)];
    lable.textColor = UIColorFromRGB(0x898989);
    lable.font = [UIFont systemFontOfSize:13.0f];
    lable.text = [_tableBtnData[section] objectForKey:@"name"];
    lable.backgroundColor = [UIColor clearColor];
    [view addSubview:lable];
    return view;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary *btnArray = [_tableBtnData[indexPath.section] objectForKey:@"top"];
    NSInteger count = btnArray.count;
    CGFloat rowHeigth = [self calculateHeigthForRow:count];
    return rowHeigth;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSDictionary *btnArray = [_tableBtnData[indexPath.section] objectForKey:@"top"];
    NSInteger count = btnArray.count;
    
    static NSString *CellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
    }
    [self initBtnView:[self createDicWith:btnArray] WithHeigth:[self calculateHeigthForRow:count] ForSection:indexPath.section];
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [cell.contentView addSubview:_btnView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark -- Private
-(NSArray *)createDicWith:(NSDictionary *)data
{
    NSMutableArray *array = [NSMutableArray array];
    NSArray *keyArray = [data allKeys];
    for (int i = 0; i < keyArray.count; i++) {
        CateModel *cateModel = [[CateModel alloc] init];
        NSString *gid = keyArray[i];
        cateModel.gid = gid;
        cateModel.gname = [data objectForKey:gid];
        [array addObject:cateModel];
    }
    return array;
}
-(CGFloat)calculateHeigthForRow:(NSInteger)count
{
    CGFloat rowHeigth,heigth = BTN_HEIGHT + BTN_SPACING;;
    if (count%3 > 0) {
         rowHeigth = heigth *(count/3 + 1) + BTN_SPACING;
    }else{
        rowHeigth = heigth*(count/3) + BTN_SPACING;
    }
    return rowHeigth;
}
@end
