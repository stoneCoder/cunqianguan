//
//  ExChangeCenterVC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/23.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "ExChangeCenterVC.h"
#import "BaseSegment.h"
#import "ExChangeCell.h"
#import <QuartzCore/QuartzCore.h>

@interface ExChangeCenterVC ()
{
    BaseSegment *_segment;
}


@end
static NSString *  collectionCellID=@"ExChangeCell";
@implementation ExChangeCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitleText:@"兑换中心"];
    [self setUpSegment];
    [self setUpCollection];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUpSegment
{
    _segment = [[BaseSegment alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 44)];
    _segment.backgroundColor = [UIColor whiteColor];
    _segment.layer.shadowOpacity = 1;
    [_segment setItems:@[@"我能兑换",@"全部商品"] isShowLine:NO];
    [self.view insertSubview:_segment aboveSubview:self.collectionView];
}

-(void)setUpCollection
{
    CGFloat visiableY = _segment.frame.size.height;
    self.collectionView.backgroundColor = UIColorFromRGB(0xECECEC);
    [self.collectionView setFrame:CGRectMake(0, visiableY, VIEW_WIDTH, self.collectionView.frame.size.height - visiableY)];
    UINib *cellNib = [UINib nibWithNibName:@"ExChangeCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:collectionCellID];
    [self setRefreshEnabled:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark -- UICollectionDelegate && UICollectionDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 16;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(VIEW_WIDTH/2 - 10, 250);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ExChangeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCellID forIndexPath:indexPath];
    cell.tag = indexPath.row;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
