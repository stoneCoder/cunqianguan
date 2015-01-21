//
//  SMViewController.m
//  SmartXHSD
//
//  Created by 左德彪 on 14-3-18.
//  Copyright (c) 2014年 com.fezo. All rights reserved.
//

#import "SMViewController.h"
#import "SMNavigationController.h"
#import "SMNavigationItem.h"
#import "SMTabBarItem.h"

@interface SMViewController ()

@property (nonatomic, readwrite, strong) SMNavigationItem *navigationItem;
@property (nonatomic, readwrite, strong) SMTabBarItem *tabBarItem;

@end

@implementation SMViewController

@synthesize navigationItem = _smNavigationItem;
@synthesize tabBarItem = _smTabbarItem;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem = [[SMNavigationItem alloc] init];
        self.tabBarItem = [[SMTabBarItem alloc] init];
        self.wantsFullScreenLayout = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
