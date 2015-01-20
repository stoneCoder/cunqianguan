//
//  BaseTBC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/19.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "BaseTBC.h"
#import "BaseNC.h"
@interface BaseTBC ()
@property(nonatomic, strong) NSArray *unselImages;//所有item未选中的图片数组
@property(nonatomic, strong) NSArray *selImages;//所有item选中的图片数组
@property(nonatomic, strong) NSMutableArray *imageViews;//所有items
@property(nonatomic, assign) NSInteger currentItemIndex;//当前item的索引
@property(nonatomic, strong) UIImageView *tabbarBackgroundView;//tabbar自定义的背景
@end

@implementation BaseTBC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    self.tabBar.backgroundImage = [[UIImage alloc] init];
    self.tabBar.selectionIndicatorImage = [[UIImage alloc] init];
    self.tabBar.backgroundColor=[UIColor whiteColor];
    
    
    self.bangLab=[[UILabel alloc]initWithFrame:CGRectMake(60, 6, 22, 22)];
    self.bangLab.backgroundColor = [UIColor colorWithRed:1 green:0.5625 blue:0 alpha:1];
    self.bangLab.layer.cornerRadius=11;
    self.bangLab.layer.masksToBounds=YES;
    self.bangLab.layer.borderColor = [[UIColor colorWithWhite:1 alpha:1] CGColor];
    self.bangLab.layer.borderWidth = 1;
    self.bangLab.font=[UIFont boldSystemFontOfSize:12.0];
    self.bangLab.textColor=[UIColor whiteColor];
    self.bangLab.text=@"";
    self.bangLab.textAlignment=NSTextAlignmentCenter;
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  功能:设置消息badge
 */

-(void)setBadgeNum:(NSString *)aNumStr{
    if (aNumStr && aNumStr.intValue>0) {
        self.bangLab.hidden=NO;
        [self.bangLab setText:aNumStr];
    } else {
        self.bangLab.hidden=YES;
    }
}



-(NSString *)currentBadgeNum{
    if (!self.bangLab.hidden) {
        return self.bangLab.text;
    }
    return nil;
}

- (void)setViewControllers:(NSArray *)viewControllers
{
    [super setViewControllers:viewControllers];
    if (self.selImages.count == 0) {
        self.unselImages = [NSArray arrayWithObjects:[UIImage imageNamed:@"tabbar_1"], [UIImage imageNamed:@"tabbar_2"], [UIImage imageNamed:@"tabbar_3"],[UIImage imageNamed:@"tabbar_3"], nil];
        self.selImages = [NSArray arrayWithObjects:[UIImage imageNamed:@"tabbar_1_sel"], [UIImage imageNamed:@"tabbar_2_sel"], [UIImage imageNamed:@"tabbar_3_sel"],[UIImage imageNamed:@"tabbar_3_sel"], nil];
    }
    self.imageViews = [[NSMutableArray alloc] initWithCapacity:0];
    
    NSInteger subviewMaxIndex = self.tabBar.subviews.count - 1;
    NSInteger otherViewCount = self.tabBar.subviews.count - viewControllers.count;
    for (NSInteger i = subviewMaxIndex; i >= otherViewCount; i--) {
        UIView *subView = [self.tabBar.subviews objectAtIndex:i];
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 106,35)];
        
        [imgView setImage:[self.unselImages objectAtIndex:i - otherViewCount]];
        [subView addSubview:imgView];
        
        if (i == subviewMaxIndex - 2) {
            [subView insertSubview:self.bangLab aboveSubview:imgView];
            self.bangLab.text = @"9";
            self.bangLab.hidden=YES;
        }
        
        [self.imageViews insertObject:imgView atIndex:0];
        
    }
    
    UIImageView *firstImgView = [self.imageViews objectAtIndex:0];
    [firstImgView setImage:[self.selImages objectAtIndex:0]];
    
    
}
- (void)selectItemAtIndex:(NSInteger)index;
{
    if (self.currentItemIndex == index) {
        return;
    }
    [[self.imageViews objectAtIndex:self.currentItemIndex] setImage:[self.unselImages objectAtIndex:self.currentItemIndex]];
    
    [[self.imageViews objectAtIndex:index] setImage:[self.selImages objectAtIndex:index]];
    self.currentItemIndex=index;
}


@end
