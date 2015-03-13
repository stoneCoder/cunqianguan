//
//  BaseCollectionVC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/19.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "BaseCollectionVC.h"
#import "UIScrollView+MJRefresh.h"
#import "BaseUtil.h"
#import "GMDCircleLoader.h"
@interface BaseCollectionVC ()
{
    UIView *_bgView;
}


@end

@implementation BaseCollectionVC

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
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setReturnBtnTitle:_leftTitle WithImage:@""];
    if (iOS7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = YES;
    }
    [self setUpEmptyView];
}

-(void)setUpEmptyView
{
    _defaultEmptyView = [DefaultEmptyView init];
    _defaultEmptyView.frame = self.view.frame;
    _defaultEmptyView.hidden = YES;
    [self.view addSubview:_defaultEmptyView];
}
#pragma mark - 返回
/**
 *  功能:隐藏返回
 */

-(void)hideReturnBackButton{
    self.navigationItem.leftBarButtonItem=nil;
    self.navigationItem.leftBarButtonItems=nil;
}
/**
 * 设置返回
 */
-(void)setupLeftButton{
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 22, 22)];
    [button setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    //[button setBackgroundImage:[UIImage imageNamed:@"back_button_sel"] forState:UIControlStateHighlighted];

    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    if (iOS7) {//iOS7 custom leftBarButtonItem 偏移
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -10;
        self.navigationItem.leftBarButtonItems = @[negativeSpacer, btnItem];
    }else{
        self.navigationItem.leftBarButtonItem = btnItem;
        
    }
    [button addTarget:self action:@selector(leftBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)setReturnBtnTitle:(NSString *)aTitle WithImage:(NSString *)imageName
{
    NSString *defaultImageName = @"back";
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectZero];
    CGRect btnFrame;
    NSString * btnTitleStr=aTitle;
    if (btnTitleStr.length > 0) {
        btnTitleStr = [NSString stringWithFormat:@"%@",aTitle];
        float width = [BaseUtil getWidthByString:btnTitleStr font:button.titleLabel.font allheight:22 andMaxWidth:200];
        btnFrame = CGRectMake(0,0,width + 22,22);
    }else{
        btnFrame = CGRectMake(0,0,22,22);
    }
    if (imageName.length > 0) {
        defaultImageName = imageName;
    }
    [button setFrame:btnFrame];
    [button setImage:[UIImage imageNamed:defaultImageName] forState:UIControlStateNormal];
    //[button setBackgroundImage:[UIImage imageNamed:@"title_left_btn_sel"] forState:UIControlStateHighlighted];
    [button setTitle:btnTitleStr forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:btnTitleStr forState:UIControlStateHighlighted];
    [button setTitleColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.5] forState:UIControlStateHighlighted];
    button.titleLabel.font=[UIFont boldSystemFontOfSize:17.0];
    
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    if (iOS7) {//iOS7 custom leftBarButtonItem 偏移
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -10;
        self.navigationItem.leftBarButtonItems = @[negativeSpacer, btnItem];
    }else{
        self.navigationItem.leftBarButtonItem = btnItem;
        
    }
    [button addTarget:self action:@selector(leftBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
}


#pragma mark-导航相关
/**
 *  功能:设置个性化标题
 */
- (void)setTitleText:(NSString *)aTitleText
{
    //标题
    UILabel *titleTextLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    titleTextLbl.backgroundColor = [UIColor clearColor];
    titleTextLbl.text = aTitleText;
    titleTextLbl.textColor = [UIColor whiteColor];
    titleTextLbl.font = [UIFont boldSystemFontOfSize:25.0];
    titleTextLbl.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleTextLbl;
}

/**
 *  功能:左按钮点击行为，可在子类重写此方法
 */
- (void)leftBtnClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setRefreshEnabled:(BOOL)enabled
{
    if (enabled) {
        [self.collectionView addHeaderWithTarget:self action:@selector(refresh)];
        [self.collectionView addFooterWithTarget:self action:@selector(moreFresh)];
    }
}

-(void)refresh
{
     [self.collectionView performSelector:@selector(headerEndRefreshing) withObject:nil afterDelay:2];
}

-(void)moreFresh
{
    [self.collectionView performSelector:@selector(footerEndRefreshing) withObject:nil afterDelay:2];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - hud
/**
 *  功能:显示hud
 */
- (void)showHUD{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
}
/**
 *  功能:显示字符串hud
 */
- (void)showHUD:(NSString *)aMessage
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = aMessage;
}
/**
 *  功能:显示字符串hud几秒钟时间
 */
- (void)showStringHUD:(NSString *)aMessage second:(int)aSecond{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = aMessage;
    [self performSelector:@selector(hideHUD) withObject:nil afterDelay:aSecond];
}
/**
 *  功能:隐藏hud
 */
- (void)hideHUD
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

/**
 *  功能:隐藏所有hud
 */
- (void)hideAllHUD
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

/**
 *  功能:接口请求失败
 */
-(void)failureHideHUD{
    [self hideHUD];
    [[CMAlert sharedCMAlert] alert:@"当前网络不稳定，请检查你的网络!"];
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

-(void)showLoaderView:(UIView *)view
{
    _bgView = [[UIView alloc] initWithFrame:CGRectZero];
    _bgView.backgroundColor = UIColorFromRGB(0xf0f0f0);
    if (view) {
        _bgView.frame = view.frame;
        [view addSubview:_bgView];
    }else{
        CGRect frame = self.view.frame;
        frame.origin.y = 0;
        _bgView.frame =  frame;
        [self.view addSubview:_bgView];
    }
    int index = [BaseUtil getRandomNumber:0 to:6];
    NSString *tipsStr = TIPS_ARRAY[index];
    [GMDCircleLoader setOnView:_bgView withTitle:DATA_LOAD andTip:tipsStr  animated:YES];
}

-(void)showLoaderView
{
    [self showLoaderView:nil];
}

-(void)hideLoaderView
{
    [GMDCircleLoader hideFromView:self.view animated:YES];
    _bgView.hidden = YES;
    [_bgView removeFromSuperview];
    _bgView = nil;
}

@end
