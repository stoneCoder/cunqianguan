//
//  SDCycleScrollView.m
//  SDCycleScrollView
//
//  Created by aier on 15-3-22.
//  Copyright (c) 2015年 GSD. All rights reserved.
//

#import "SDCycleScrollView.h"
#import "SDCollectionViewCell.h"
#import "UIView+SDExtension.h"
#import "TAPageControl.h"
#import "NSData+SDDataCache.h"

NSString * const ID = @"cycleCell";

@interface SDCycleScrollView () <UICollectionViewDataSource, UICollectionViewDelegate>


@property (nonatomic, weak) UICollectionView *mainView; // 显示图片的collectionView
@property (nonatomic, weak) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) NSMutableArray *imagesGroup;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger totalItemsCount;
@property (nonatomic, weak) TAPageControl *pageControl;

@end

@implementation SDCycleScrollView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initialization];
        [self setupMainView];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self initialization];
        [self setupMainView];
    }
    return self;
}

- (void)initialization
{
    _pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    _autoScrollTimeInterval = 1.0;
    _titleLabelTextColor = [UIColor whiteColor];
    _titleLabelTextFont= [UIFont systemFontOfSize:14];
    _titleLabelBackgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    _titleLabelHeight = 30;
    self.backgroundColor = [UIColor lightGrayColor];
}

+ (instancetype)cycleScrollViewWithFrame:(CGRect)frame imagesGroup:(NSArray *)imagesGroup
{
    SDCycleScrollView *cycleScrollView = [[self alloc] initWithFrame:frame];
    cycleScrollView.imagesGroup = [NSMutableArray arrayWithArray:imagesGroup];
    return cycleScrollView;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    _flowLayout.itemSize = self.frame.size;
}

- (void)setPageControlDotSize:(CGSize)pageControlDotSize
{
    _pageControlDotSize = pageControlDotSize;
    _pageControl.dotSize = pageControlDotSize;
}

- (void)setDotColor:(UIColor *)dotColor
{
    _dotColor = dotColor;
    _pageControl.dotColor = dotColor;
}

- (void)setAutoScrollTimeInterval:(CGFloat)autoScrollTimeInterval
{
    _autoScrollTimeInterval = autoScrollTimeInterval;
    
    [_timer invalidate];
    _timer = nil;
    [self setupTimer];
}

// 设置显示图片的collectionView
- (void)setupMainView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = self.frame.size;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _flowLayout = flowLayout;
    
    UICollectionView *mainView = [[UICollectionView alloc] initWithFrame:self.frame collectionViewLayout:flowLayout];
    mainView.backgroundColor = [UIColor clearColor];
    mainView.pagingEnabled = YES;
    mainView.showsHorizontalScrollIndicator = NO;
    mainView.showsVerticalScrollIndicator = NO;
    [mainView registerClass:[SDCollectionViewCell class] forCellWithReuseIdentifier:ID];
    mainView.dataSource = self;
    mainView.delegate = self;
    [self addSubview:mainView];
    _mainView = mainView;
}

- (void)setImagesGroup:(NSMutableArray *)imagesGroup
{
    _imagesGroup = imagesGroup;
    _totalItemsCount = imagesGroup.count * 100;
    
    [self setupTimer];
    [self setupPageControl];
}

- (void)setLocalizationImagesGroup:(NSArray *)localizationImagesGroup
{
    _localizationImagesGroup = localizationImagesGroup;
    self.imagesGroup = [NSMutableArray arrayWithArray:localizationImagesGroup];
}

- (void)setupPageControl
{
    if (_pageControl) [_pageControl removeFromSuperview]; // 重新加载数据时调整
    TAPageControl *pageControl = [[TAPageControl alloc] init];
    pageControl.numberOfPages = self.imagesGroup.count;
    [self addSubview:pageControl];
    _pageControl = pageControl;
}


- (void)automaticScroll
{
    if (0 == _totalItemsCount) return;
    int currentIndex = _mainView.contentOffset.x / _flowLayout.itemSize.width;
    int targetIndex = currentIndex + 1;
    if (targetIndex == _totalItemsCount) {
        targetIndex = _totalItemsCount * 0.5;
        [_mainView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
    [_mainView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}

- (void)setupTimer
{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:self.autoScrollTimeInterval target:self selector:@selector(automaticScroll) userInfo:nil repeats:YES];
    _timer = timer;
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _mainView.frame = self.bounds;
    if (_mainView.contentOffset.x == 0 &&  _totalItemsCount) {
        [_mainView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_totalItemsCount * 0.5 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
    
    if (self.dotImage) {
        _pageControl.dotImage = self.dotImage;
    }
    if (self.currentDotImage) {
        _pageControl.currentDotImage = self.currentDotImage;
    }
    
    CGSize size = [_pageControl sizeForNumberOfPages:self.imagesGroup.count];
    CGFloat x = (self.sd_width - size.width) * 0.5;
    if (self.pageControlAliment == SDCycleScrollViewPageContolAlimentRight) {
        x = self.mainView.sd_width - size.width - 10;
    }
    CGFloat y = self.mainView.sd_height - size.height - 10;
    _pageControl.frame = CGRectMake(x, y, size.width, size.height);
    [_pageControl sizeToFit];
}
//解决当父View释放时，当前视图因为被Timer强引用而不能释放的问题
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (!newSuperview) {
        [_timer invalidate];
        _timer = nil;
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _totalItemsCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SDCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    long itemIndex = indexPath.item % self.imagesGroup.count;
    
    if (itemIndex < self.imagesGroup.count) {
        NSString *urlString = self.imagesGroup[itemIndex];
        if ([urlString isKindOfClass:[UIImage class]]) {
            cell.imageView.image = (UIImage *)urlString;
        } else if ([urlString hasPrefix:@"http://"]
                   || [urlString hasPrefix:@"https://"]
                   || [urlString hasPrefix:@"/"]) {
            [cell.imageView sd_setImageWithURL:[NSURL URLWithString:urlString]];
        } else {
            cell.imageView.image = [UIImage imageNamed:urlString];
        }
    }
    if (_titlesGroup.count) {
        cell.title = _titlesGroup[itemIndex];
    }
    
    if (!cell.hasConfigured) {
        cell.titleLabelBackgroundColor = self.titleLabelBackgroundColor;
        cell.titleLabelHeight = self.titleLabelHeight;
        cell.titleLabelTextColor = self.titleLabelTextColor;
        cell.titleLabelTextFont = self.titleLabelTextFont;
        cell.hasConfigured = YES;
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.selectItemBlock) {
        self.selectItemBlock(indexPath.item % self.imagesGroup.count);
    }
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int itemIndex = (scrollView.contentOffset.x + self.mainView.sd_width * 0.5) / self.mainView.sd_width;
    if (!self.imagesGroup.count) return; // 解决清除timer时偶尔会出现的问题
    int indexOnPageControl = itemIndex % self.imagesGroup.count;
    _pageControl.currentPage = indexOnPageControl;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_timer invalidate];
    _timer = nil;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self setupTimer];
}



@end
