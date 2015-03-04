//
//  CalendarView.m
//  cunqianguan
//
//  Created by 四三一八 on 15/3/3.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "CalendarView.h"
#import "CalendarViewCell.h"
static NSString *calendarCellID = @"CalendarViewCell";
@implementation CalendarView
{
    NSArray *_data;
    NSDate *_nowDate;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        [self setUpView];
    }
    return self;
}

-(void)reloadDataWith:(NSArray *)data andNowDate:(NSDate *)date;
{
    _data = data;
    _nowDate = date;
    [self reloadData];
}

-(void)setUpView
{
    [self registerClass:[CalendarViewCell class] forCellWithReuseIdentifier:calendarCellID];
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return _data.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self calculateSize];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CalendarViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:calendarCellID forIndexPath:indexPath];
    SignModel *model = _data[indexPath.row];
    [cell loadCell:model andNowDate:_nowDate];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

}

#pragma mark -- Private
-(CGSize)calculateSize
{
    if (_data.count > 0) {
        CGFloat visiableHight = 0;
        CGFloat visiableWidth = SCREEN_WIDTH/8;
        NSInteger rowNum = _data.count%7;
        if (rowNum > 1) {
            rowNum = _data.count/7 + 1;
            visiableHight = self.frame.size.height/rowNum - 3;
        }else{
            rowNum = _data.count/7;
            visiableHight = self.frame.size.height/rowNum - 3;
        }
        return CGSizeMake(visiableWidth, visiableHight);
    }else{
        return CGSizeZero;
    }
    
}
@end
