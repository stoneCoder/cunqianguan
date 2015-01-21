//
//  SMTabBarController.m
//  SmartXHSD
//
//  Created by 左德彪 on 14-3-17.
//  Copyright (c) 2014年 com.fezo. All rights reserved.
//

#import "SMTabBarController.h"
#import "SMTabBarItem.h"
#import "SMNavigationController.h"

@interface SMViewController ()

@property(nonatomic,readwrite,strong) SMTabBarController *tabBarController;

@end

@implementation SMViewController (SMTabBarControllerItem)

- (void)setTabBarController:(SMTabBarController *)tabBarController
{
    _tabBarController = tabBarController;
}

@end

@interface SMTabBarController ()

@end

@implementation SMTabBarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.childControllers = [NSMutableArray array];
        self.view.backgroundColor = [UIColor whiteColor];
        self.tabBar = [[SMTabBar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-TABBAR_HEIGHT,
                                                                 self.view.frame.size.width, TABBAR_HEIGHT)];
        self.tabBar.backgroundColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
        [self.view addSubview:self.tabBar];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect rect = self.view.frame;
    NSLog(@"TabBarController (%f,%f,%f,%f)", rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);
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

- (void)addChildViewController:(SMViewController *)childController
{
    SMViewController *viewController = childController;
    
    [self.childControllers addObject:childController];
    // if childController is SMNavigationController class, get the top view controller of this class
    if ([childController isKindOfClass:[SMNavigationController class]]) {
        SMNavigationController *navi = (SMNavigationController*)childController;
        viewController = navi.topViewController;
    }
    viewController.tabBarController = self;
    [self.tabBar addTabBarItem:viewController.tabBarItem];
    childController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-TABBAR_HEIGHT);
    [self.view addSubview:childController.view];
    if (self.childControllers.count > 1) {
        [viewController.view setHidden:YES];
    } else {
        self.selectedIndex = 0;
        self.selectedViewController = viewController;
    }
    [viewController.tabBarItem addTarget:self action:@selector(onTouchDown:) forControlEvents:UIControlEventTouchDown];
    [viewController.tabBarItem addTarget:self action:@selector(onTouchUp:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside];
}

- (void)onTouchDown:(SMTabBarItem*)item
{
    for (int i=0; i<self.childControllers.count; i++) {
        SMViewController *childController = [self.childControllers objectAtIndex:i];
        SMViewController *viewController = childController;
        
        if ([childController isKindOfClass:[SMNavigationController class]]) {
            SMNavigationController *navi = (SMNavigationController*)childController;
            viewController = navi.topViewController;
        }
        if (viewController.tabBarItem == item) {
            [self.selectedViewController.view setHidden:YES]; // hide last select view controller
            
            [viewController.view setHidden:NO];
            self.selectedIndex = i;
            self.selectedViewController = viewController;
            break;
        }
    }
}

- (void)onTouchUp:(SMTabBarItem*)item
{
    
}

@end

