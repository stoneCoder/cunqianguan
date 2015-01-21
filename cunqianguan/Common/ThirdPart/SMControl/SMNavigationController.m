//
//  SMNavigationController.m
//  SmartXHSD
//
//  Created by 左德彪 on 14-3-18.
//  Copyright (c) 2014年 com.fezo. All rights reserved.
//

#import "SMNavigationController.h"
#import "SMNavigationItem.h"
#import "SMNavigationBar.h"
#import "SMConstant.h"
#import "SMTabBarController.h"

@interface SMNavigationItem ()

- (void)setNavigationBar:(SMNavigationBar*)bar;

@end

@interface SMViewController ()

@property (nonatomic, readwrite, strong) SMNavigationController *navigationController; // switch read-write mode
@property (nonatomic, readwrite, strong) SMTabBarController *tabBarController;

@end

@interface SMNavigationController ()

@property(nonatomic, readwrite, strong) SMViewController *topViewController;
@property(nonatomic, readwrite, strong) SMViewController *visibleViewController;
@property(nonatomic, readwrite, strong) SMNavigationBar *navigationBar;

@end

@implementation SMNavigationController

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

- (id)initWithRootViewController:(SMViewController *)rootViewController
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        NSLog(@"subviews %f", self.view.frame.size.height);
        [rootViewController setNavigationController:self];
        self.topViewController = self.visibleViewController = rootViewController;
        self.navigationBar = [[SMNavigationBar alloc] initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT, self.view.frame.size.width, NAVIGATION_BAR_LENGTH)];
        // associate navigationBar with navigationItem
        [self.navigationItem setNavigationBar:self.navigationBar];
        // set navigationBar background color
        self.navigationBar.backgroundColor = [UIColor grayColor];
        self.viewControllers = [NSMutableArray arrayWithObjects:rootViewController, nil];
        [self.view addSubview:self.navigationBar];
        [self.view addSubview:rootViewController.view];
        NSLog(@"home %f,%f,%f,%f", rootViewController.view.frame.origin.x, rootViewController.view.frame.origin.y,
              rootViewController.view.frame.size.width, rootViewController.view.frame.size.height);
    }
    return self;
}

- (void)viewDidLayoutSubviews
{
    if (self.visibleViewController) {
        CGFloat contentHeight = self.view.frame.size.height-NAVIGATION_BAR_LENGTH-STATUS_BAR_HEIGHT;
        
        NSLog(@"navigation controller %f, %f", self.view.frame.size.height, contentHeight);
        self.navigationBar.frame = CGRectMake(0, STATUS_BAR_HEIGHT, self.view.frame.size.width, NAVIGATION_BAR_LENGTH);
        self.visibleViewController.view.frame = CGRectMake(0, NAVIGATION_BAR_LENGTH+STATUS_BAR_HEIGHT, self.view.frame.size.width, contentHeight);
        //[self.visibleViewController.view setNeedsLayout];
    }
}

- (void)pushViewController:(SMViewController *)viewController animated:(BOOL)animated
{
    
}

- (SMViewController *)popViewControllerAnimated:(BOOL)animated
{
    return nil;
}

- (void)setViewControllers:(NSArray *)viewControllers animated:(BOOL)animated
{
    
}

- (void)setNavigationBarHidden:(BOOL)hidden animated:(BOOL)animated
{
    
}

- (void)setTabBarController:(SMTabBarController *)tabBarController
{
    self.topViewController.tabBarController = tabBarController;
}

@end

@implementation SMViewController (SMNavigationItem)

- (SMNavigationController*)navigationController
{
    return _navigationController;
}

- (void)setNavigationController:(SMNavigationController *)smnavigationController
{
    _navigationController = smnavigationController;
}

@end


