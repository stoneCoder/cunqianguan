//
//  SMTabBar.m
//  SmartXHSD
//
//  Created by 左德彪 on 14-3-17.
//  Copyright (c) 2014年 com.fezo. All rights reserved.
//

#import "SMTabBar.h"
#import "SMViewController.h"

@interface SMTabBar ()

@property (strong, nonatomic) NSMutableArray *tabbarItems;
@property (strong, nonatomic) NSMutableArray *viewControllers;
@property (strong, nonatomic) UIImageView *backgroundImageView;

@end

@implementation SMTabBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tabbarItems = [NSMutableArray array];
        //self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tab_bg.png"]];
        //self.titleColor = [UIColor grayColor];
        //self.selectedTitleColor = [UIColor redColor];
        self.backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        //[self addSubview:self.backgroundImageView];
    }
    return self;
}

- (void)setTabBarItems:(NSArray *)items
{
    for (int i=0; i<self.tabbarItems.count; i++) {
        SMTabBarItem *smitem = [self.tabbarItems objectAtIndex:i];
        [smitem removeFromSuperview];
        [smitem removeTarget:self action:@selector(onTouchDown:) forControlEvents:UIControlEventTouchDown];
        [smitem removeTarget:self action:@selector(onTouchUp:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside];
    }
    [self.tabbarItems removeAllObjects];
    for (int i=0; i<items.count; i++) {
        SMTabBarItem *smitem = [items objectAtIndex:i];
        
        [smitem addTarget:self action:@selector(onTouchDown:) forControlEvents:UIControlEventTouchDown];
        [smitem addTarget:self action:@selector(onTouchUp:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside];
        [self addSubview:smitem];
        [self.tabbarItems addObject:smitem];
    }
    [self setNeedsLayout];
}

- (void)setBackgroundImage:(UIImage *)backgroundImage
{
    [self.backgroundImageView setImage:backgroundImage];
}

- (void)addTabBarItem:(SMTabBarItem*)item
{
    [item addTarget:self action:@selector(onTouchDown:) forControlEvents:UIControlEventTouchDown];
    [item addTarget:self action:@selector(onTouchUp:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside];
    [self addSubview:item];
    [self.tabbarItems addObject:item];
}

- (void)onTouchDown:(SMTabBarItem*)item
{
    if (item == self.selectedItem) {
        return;
    }
    if (self.selectedItem) {
        self.selectedItem.titleLabel.textColor = self.titleColor;
        self.selectedItem.imageView.image = self.selectedItem.image;
    }
    item.titleLabel.textColor = self.selectedTitleColor;
    item.imageView.image = item.selectedImage;
    self.selectedItem = item;
}

- (void)onTouchUp:(SMTabBarItem*)item
{

}

- (void)layoutSubviews
{
    CGFloat tarbarItemWidth = self.tabbarItems.count < 5?self.frame.size.width/self.tabbarItems.count:self.frame.size.width/5;
    CGFloat xOffset = 0;
    
    for (int i=0; i<self.tabbarItems.count; i++) {
        SMTabBarItem *item = [self.tabbarItems objectAtIndex:i];
        item.frame = CGRectMake(xOffset, 0, tarbarItemWidth, self.frame.size.height);
        xOffset += tarbarItemWidth;
    }
    [super layoutSubviews];
}

@end
