//
//  GuideVC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/3/17.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "GuideVC.h"

@interface GuideVC ()

@end

@implementation GuideVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        CGFloat topOffset = 0;
        self.view.backgroundColor = [UIColor whiteColor];
        
        self.guideView = [[GuideView alloc] initWithFrame:CGRectMake(0, topOffset, SCREEN_WIDTH, SCREEN_HEIGTH)];
        [self.guideView.buttonStart addTarget:self action:@selector(onStart) forControlEvents:UIControlEventTouchUpInside];
        self.guideView.delegate = self;
        [self.view addSubview:self.guideView];
        
        
        self.pageControl = [[CustomPageControl alloc] initWithFrame:CGRectMake(0, 0, 80, 20)];
        self.pageControl.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGTH-20);
        self.pageControl.numberOfPages = 3;
        self.pageControl.currentPage = 0;
        [self.pageControl setPageIndicatorImage:[UIImage imageNamed:@"qiehuan"]];
        [self.pageControl setCurrentPageIndicatorImage:[UIImage imageNamed:@"qiehuan_down"]];
        [self.view addSubview:self.pageControl];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onStart
{
    [self dismissViewControllerAnimated:YES completion:^{
        [self setHasRead];
        [[NSNotificationCenter defaultCenter] postNotificationName:kHomeTipShow object:nil];
    }];
}

- (void)setHasRead
{
    [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"showGuide"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark -- UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    
    int page = self.guideView.contentOffset.x/290;
    self.pageControl.currentPage = page;
}

@end
