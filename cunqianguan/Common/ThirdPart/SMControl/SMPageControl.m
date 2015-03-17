//
//  UIBannerView.m
//  ControlTest
//
//  Created by apple on 14-3-2.
//  Copyright (c) 2014年 fezo. All rights reserved.
//

#import "SMPageControl.h"
#import "SMIndication.h"

#define DEFAULT_BANNER_PAGENUMBER 6
#define INDICATION_WIDTH 18
#define INDICATION_HEIGHT 4
#define INDICATION_SPACING 8

@interface SMPageControl ()

@property (nonatomic, strong) NSMutableArray *pages;
@property (nonatomic, strong) NSMutableArray *indicationViews;

@property (nonatomic, assign) CGPoint beginPoint;
@property (nonatomic, strong) UIView *lastPage;
@property (nonatomic, strong) UIView *nextPage;
@property (nonatomic, assign) BOOL autoScrollPage;
@property (nonatomic, assign) BOOL autoScrollToLastOrNextPage; // YES-last page NO-next page
@property (nonatomic, strong) NSTimer *scrollTimer;
@property (atomic, strong) NSLock *scrollLock;
@property (nonatomic, assign) BOOL canGestureScroll;

- (void)resetCurrentPage;
- (void)scrollToLastPage;
- (void)scrollToNextPage;

@end

@implementation SMPageControl

@synthesize pages;
@synthesize indicationViews;
@synthesize currentPageIndex;
@synthesize currentPage;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.pages = [[NSMutableArray alloc] init];
        self.indicationViews = [[NSMutableArray alloc] init];
        self.scrollLock = [[NSLock alloc] init];
        self.currentPageIndex = 0;
        self.autoScrollPage = YES;
        self.autoScrollToLastOrNextPage = NO;
        self.canGestureScroll = NO;
        self.layer.masksToBounds = YES;
        currentPage = nil;
        self.scrollTimer = [NSTimer scheduledTimerWithTimeInterval:4.0f target:self selector:@selector(onScrollTimer:) userInfo:nil repeats:YES];
        [self addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)]];
    }
    return self;
}

- (void)onScrollTimer:(NSTimer*)timer
{
    if ([self.scrollLock tryLock] && self.autoScrollPage && self.pages.count > 0) {
        NSUInteger lastIndex = currentPageIndex-1, nextIndex = currentPageIndex+1;
        
        if (lastIndex == 0) {
            lastIndex = pages.count;
        }
        if (nextIndex > pages.count) {
            nextIndex = 1;
        }
        //NSLog(@"last=%d, current=%d, next=%d", lastIndex, currentPageIndex, nextIndex);
        self.lastPage = [pages objectAtIndex:lastIndex-1];
        self.lastPage.hidden = NO;
        self.lastPage.frame = CGRectMake(-self.frame.size.width, 0, self.frame.size.width, self.frame.size.height);
        self.nextPage = [pages objectAtIndex:nextIndex-1];
        self.nextPage.hidden = NO;
        self.nextPage.frame = CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height);
        self.autoScrollToLastOrNextPage?[self scrollToLastPage]:[self scrollToNextPage];
    }
}

- (void)handleGesture:(UIGestureRecognizer*)gestureRecognizer
{
    if (currentPage > 0) {
        switch ([gestureRecognizer state]) {
            case UIGestureRecognizerStateBegan:
            {
                if ([self.scrollLock tryLock]) {
                    NSUInteger lastIndex = currentPageIndex-1, nextIndex = currentPageIndex+1;
                    
                    if (lastIndex == 0) {
                        lastIndex = pages.count;
                    }
                    if (nextIndex > pages.count) {
                        nextIndex = 1;
                    }
                    self.autoScrollPage = NO;
                    self.canGestureScroll = YES;
                    self.beginPoint = [gestureRecognizer locationInView:self];
                    self.lastPage = [pages objectAtIndex:lastIndex-1];
                    self.lastPage.hidden = NO;
                    self.lastPage.frame = CGRectMake(-self.frame.size.width, 0, self.frame.size.width, self.frame.size.height);
                    self.nextPage = [pages objectAtIndex:nextIndex-1];
                    self.nextPage.hidden = NO;
                    self.nextPage.frame = CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height);
                } else {
                    self.canGestureScroll = NO;
                }
                break;
            }
            case UIGestureRecognizerStateChanged:
            {
                if (self.canGestureScroll) {
                    CGPoint current = [gestureRecognizer locationInView:self];
                    CGFloat delta = current.x - self.beginPoint.x;
                    CGRect pageFrame = self.currentPage.frame;
                    CGRect lastPageFrame = self.lastPage.frame;
                    CGRect nextPageFrame = self.nextPage.frame;
                    
                    pageFrame.origin.x = delta;
                    lastPageFrame.origin.x = -self.frame.size.width + delta;
                    nextPageFrame.origin.x = self.frame.size.width + delta;
                    self.currentPage.frame = pageFrame;
                    self.lastPage.frame = lastPageFrame;
                    self.nextPage.frame = nextPageFrame;
                }
                break;
            }
            case UIGestureRecognizerStateEnded:
            case UIGestureRecognizerStateCancelled:
            {
                if (self.canGestureScroll) {
                    CGPoint current = [gestureRecognizer locationInView:self];
                    CGFloat delta = current.x - self.beginPoint.x;
                    if (delta > 0) {
                        if (abs(delta) > self.frame.size.width/5) {
                            // switch next page
                            [self scrollToLastPage];
                        } else {
                            // reset current page
                            [self resetCurrentPage];
                        }
                    } else {
                        if (abs(delta) > self.frame.size.width/5) {
                            // switch next page
                            [self scrollToNextPage];
                        } else {
                            // reset current page
                            [self resetCurrentPage];
                        }
                    }
                    self.autoScrollPage = YES;
                    [self setNeedsLayout];
                }
                break;
            }
            default:
                break;
        }
    }
}

- (void)resetCurrentPage
{
    [UIView animateWithDuration:0.2f animations:^{
        CGRect currentFrame = currentPage.frame;
        CGRect lastFrame = self.lastPage.frame;
        CGRect nextFrame = self.nextPage.frame;
        lastFrame.origin.x = -self.frame.size.width;
        nextFrame.origin.x = self.frame.size.width;
        currentFrame.origin.x = 0;
        self.lastPage.frame = lastFrame;
        self.nextPage.frame = nextFrame;
        self.currentPage.frame = currentFrame;
    } completion:^(BOOL finished) {
        self.lastPage.hidden = self.nextPage.hidden = YES;
        [self.scrollLock unlock];
        [self setNeedsLayout];
    }];
}

- (void)scrollToLastPage
{
    --currentPageIndex;
    if (currentPageIndex  == 0) {
        currentPageIndex = pages.count;
    }
    
    [UIView animateWithDuration:0.2f animations:^{
        CGRect currentFrame = currentPage.frame;
        CGRect lastFrame = self.lastPage.frame;
        lastFrame.origin.x = 0;
        currentFrame.origin.x = self.frame.size.width;
        self.lastPage.frame = lastFrame;
        self.currentPage.frame = currentFrame;
    } completion:^(BOOL finished) {
        self.currentPage.hidden = self.nextPage.hidden = YES;
        currentPage = [pages objectAtIndex:currentPageIndex-1];
        [self.scrollLock unlock];
        [self setNeedsLayout];
    }];
}

- (void)scrollToNextPage
{
    ++currentPageIndex;
    if (currentPageIndex > pages.count) {
        currentPageIndex = 1;
    }
    
    [UIView animateWithDuration:0.2f animations:^{
        CGRect currentFrame = currentPage.frame;
        CGRect nextFrame = self.nextPage.frame;
        nextFrame.origin.x = 0;
        currentFrame.origin.x = -self.frame.size.width;
        self.nextPage.frame = nextFrame;
        self.currentPage.frame = currentFrame;
    } completion:^(BOOL finished) {
        self.currentPage.hidden = self.lastPage.hidden = YES;
        currentPage = [pages objectAtIndex:currentPageIndex-1];
        [self.scrollLock unlock];
        [self setNeedsLayout];
    }];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //NSLog(@"current Page Index = %d", currentPageIndex);
    
    if (indicationViews.count > 0) {
        NSUInteger width = self.frame.size.width;
        NSUInteger indicationWidth = indicationViews.count*INDICATION_WIDTH + (indicationViews.count-1)*INDICATION_SPACING;
        NSUInteger left = (width - indicationWidth)/2 ;
        NSUInteger top = self.frame.size.height - INDICATION_HEIGHT - 5;
        
        // layout indication views
        for (NSUInteger i=0; i<indicationViews.count; i++) {
            SMIndication *biv = [indicationViews objectAtIndex:i];
            [biv setFrame:CGRectMake(left+i*(INDICATION_WIDTH+INDICATION_SPACING), top, INDICATION_WIDTH, INDICATION_HEIGHT)];
            [biv setIndicating:(currentPageIndex == (i+1))];
            [biv setHidden:NO];
            [self bringSubviewToFront:biv];
        }
    }
}

- (void)insertBannerPages:(UIView*)page
{
    if (!page) {
        return;
    }
    SMIndication *biv = [[SMIndication alloc] initWithFrame:CGRectMake(0, 0, INDICATION_WIDTH, INDICATION_HEIGHT)];
    [pages addObject:page];
    [indicationViews addObject:biv];
    page.hidden = biv.hidden = YES;
    [self addSubview:biv];
    [self addSubview:page];
    if (currentPageIndex == 0) {
        currentPageIndex = 1;
        currentPage = page;
        [self.currentPage setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [self.currentPage setHidden:NO];
    }
    //[self setNeedsLayout];
}

- (void)removeAllBannerPages
{
    for (NSUInteger i=0; i<pages.count; i++) {
        UIView *page = [pages objectAtIndex:i];
        [page removeFromSuperview];
    }
    for (NSUInteger i=0; i<indicationViews.count; i++) {
        SMIndication *biv = [indicationViews objectAtIndex:i];
        [biv removeFromSuperview];
    }
    [pages removeAllObjects];
    [indicationViews removeAllObjects];
    currentPageIndex = 0;
    currentPage = nil;
    [self.scrollLock unlock];
}

@end
