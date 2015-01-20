//
//  BaseNC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/19.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "BaseNC.h"

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
    self.navigationController.navigationBar.translucent = YES;
    self.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationBar setBarTintColor:UIColorFromRGB(0x4DD8CB)];

//    if (iOS7) {
//         [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"title_bg_ios7"] forBarMetrics:UIBarMetricsDefault];
//
//    } else {
//         [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"title_bg"] forBarMetrics:UIBarMetricsDefault];
//         self.navigationBar.barTintColor = [UIColor redColor];
//    }
   
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
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
