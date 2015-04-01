//
//  BaseNC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/19.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "BaseNC.h"
#import "BaseUtil.h"
@interface BaseNC ()

@end

@implementation BaseNC

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
    if (iOS7) {
        [self setNeedsStatusBarAppearanceUpdate];
    }
    // Do any additional setup after loading the view.

    [self setUpNavBgColor];
}

-(void)setUpNavBgColor
{
    if (iOS7) {
        [self.navigationBar setBarTintColor:UIColorFromRGB(0x32dacd)];
        self.navigationBar.translucent = NO;
    }else{
        [self.navigationBar setBackgroundImage:[BaseUtil imageWithColor:UIColorFromRGB(0x32dacd)] forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setTintColor:UIColorFromRGB(0x32dacd)];
    }
    
    /*去掉navigationBar底部阴影*/
    for (UIView *view in [[[self.navigationBar subviews] objectAtIndex:0] subviews]) {
        if ([view isKindOfClass:[UIImageView class]]) view.hidden = YES;
    }
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (BOOL)prefersStatusBarHidden
{
    return NO;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
