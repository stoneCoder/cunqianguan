//
//  BaseVC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/19.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "BaseVC.h"
#import "BaseNC.h"
#import "CMAlert.h"
#import "BaseUtil.h"
#import "DefaultEmptyView.h"
@interface BaseVC ()


@end

@implementation BaseVC

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
    [self.view setBackgroundColor:UIColorFromRGB(0xececec)];
    [self setReturnBtnTitle:_leftTitle WithImage:@""];
    //滑动返回
    if (self.navigationController.viewControllers.count >1) {
        UISwipeGestureRecognizer * recognizer=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(tuchReturnBack:)];
        [recognizer setDirection:UISwipeGestureRecognizerDirectionRight];
        [self.view addGestureRecognizer:recognizer];
    }
    if (iOS7) {
        self.edgesForExtendedLayout =UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self setUpEmptyView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [((BaseNC *)self.navigationController) setUpNavBgColor];
}

-(void)setUpEmptyView
{
    _defaultEmptyView = [DefaultEmptyView init];
    _defaultEmptyView.frame = self.view.frame;
    _defaultEmptyView.hidden = YES;
    [self.view addSubview:_defaultEmptyView];
}
/**
 *  功能:滑动返回
 */

-(void)tuchReturnBack:(UISwipeGestureRecognizer *)recognizer{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 返回按钮
/**
 *  功能:显示左按钮
 *  aVisible:是否显示按钮
 */
- (void)makeNaviLeftButtonVisible:(BOOL)aVisible{
    if (aVisible) {
        [self setReturnBtnTitle:@"返回" BadgeNumber:0];
    }
}

/**
 *  功能:设置返回按钮个性化标题
 */
-(void)setReturnBtnTitle:(NSString *)aTitle BadgeNumber:(int)aNumber{
    CGRect btnFrame;
    NSString * btnTitleStr=aTitle;
    if (aNumber>0) {
        btnTitleStr=[NSString stringWithFormat:@"%@(%d)",aTitle,aNumber];
        btnFrame=CGRectMake(0,0,70,44);
    }else{
        btnFrame=CGRectMake(0,0,50,44);
    }
    UIButton *button = [[UIButton alloc] initWithFrame:btnFrame];
    [button setBackgroundImage:[UIImage imageNamed:@"title_left_btn"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"title_left_btn_sel"] forState:UIControlStateHighlighted];
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

-(void)setReturnBtnTitle:(NSString *)aTitle WithImage:(NSString *)imageName
{
    [self setReturnBtnTitle:aTitle WithImage:imageName andHighlightImage:nil];
}

-(void)setReturnBtnTitle:(NSString *)aTitle WithImage:(NSString *)imageName andHighlightImage:(NSString *)highlightImage

{
    [self setReturnBtnTitle:aTitle WithImage:imageName andHighlightImage:highlightImage edgeInsetsWithTitle:0];
}

-(void)setReturnBtnTitle:(NSString *)aTitle WithImage:(NSString *)imageName andHighlightImage:(NSString *)highlightImage edgeInsetsWithTitle:(CGFloat)insets
{
    [self setReturnBtnTitle:aTitle titleColor:nil highlightedTileColor:nil WithImage:imageName andHighlightImage:highlightImage edgeInsetsWithTitle:insets];
//    NSString *defaultImageName = @"back";
//    NSString *defaulthighlightImageName = @"back_hover";
//    UIButton *button = [[UIButton alloc] initWithFrame:CGRectZero];
//    CGRect btnFrame;
//    NSString * btnTitleStr=aTitle;
//    if (btnTitleStr.length > 0) {
//        btnTitleStr = [NSString stringWithFormat:@"%@",aTitle];
//        float width = [BaseUtil getWidthByString:btnTitleStr font:button.titleLabel.font allheight:22 andMaxWidth:200];
//        btnFrame = CGRectMake(0,0,width + 22 + insets,22);
//    }else{
//        btnFrame = CGRectMake(0,0,22,22);
//    }
//    if (imageName.length > 0) {
//        defaultImageName = imageName;
//    }
//    [button setFrame:btnFrame];
//    [button setImage:[UIImage imageNamed:defaultImageName] forState:UIControlStateNormal];
//    if (highlightImage) {
//        [button setImage:[UIImage imageNamed:highlightImage] forState:UIControlStateHighlighted];
//    }else{
//        [button setImage:[UIImage imageNamed:defaulthighlightImageName] forState:UIControlStateHighlighted];
//    }
//    [button setTitle:btnTitleStr forState:UIControlStateNormal];
//    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [button setTitle:btnTitleStr forState:UIControlStateHighlighted];
//    [button setTitleColor:UIColorFromRGB(0x1a9c92) forState:UIControlStateHighlighted];
//    button.titleLabel.font=[UIFont boldSystemFontOfSize:17.0];
//    button.titleEdgeInsets = UIEdgeInsetsMake(0, insets, 0, 0);
//    
//    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithCustomView:button];
//    if (iOS7) {//iOS7 custom leftBarButtonItem 偏移
//        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//        negativeSpacer.width = -10;
//        self.navigationItem.leftBarButtonItems = @[negativeSpacer, btnItem];
//    }else{
//        self.navigationItem.leftBarButtonItem = btnItem;
//        
//    }
//    [button addTarget:self action:@selector(leftBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)setReturnBtnTitle:(NSString *)aTitle titleColor:(UIColor *)titleColor highlightedTileColor:(UIColor *)highlightedTileColor WithImage:(NSString *)imageName andHighlightImage:(NSString *)highlightImage edgeInsetsWithTitle:(CGFloat)insets
{
    NSString *defaultImageName = @"back";
    NSString *defaulthighlightImageName = @"back_hover";
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectZero];
    CGRect btnFrame;
    NSString * btnTitleStr=aTitle;
    if (btnTitleStr.length > 0) {
        btnTitleStr = [NSString stringWithFormat:@"%@",aTitle];
        float width = [BaseUtil getWidthByString:btnTitleStr font:button.titleLabel.font allheight:22 andMaxWidth:200];
        btnFrame = CGRectMake(0,0,width + 22 + insets,22);
    }else{
        btnFrame = CGRectMake(0,0,22,22);
    }
    if (imageName.length > 0) {
        defaultImageName = imageName;
    }
    [button setFrame:btnFrame];
    [button setImage:[UIImage imageNamed:defaultImageName] forState:UIControlStateNormal];
    if (highlightImage) {
        [button setImage:[UIImage imageNamed:highlightImage] forState:UIControlStateHighlighted];
    }else{
        [button setImage:[UIImage imageNamed:defaulthighlightImageName] forState:UIControlStateHighlighted];
    }
    [button setTitle:btnTitleStr forState:UIControlStateNormal];
    if (titleColor) {
        [button setTitleColor:titleColor forState:UIControlStateNormal];
    }else{
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    [button setTitle:btnTitleStr forState:UIControlStateHighlighted];
//    if (titleColor) {
//        [button setTitleColor:highlightedTileColor forState:UIControlStateHighlighted];
//    }else{
//        [button setTitleColor:UIColorFromRGB(0x1a9c92) forState:UIControlStateHighlighted];
//    }
    button.titleLabel.font=[UIFont boldSystemFontOfSize:17.0];
    button.titleEdgeInsets = UIEdgeInsetsMake(0, insets, 0, 0);
    
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
#pragma mark - 返回
/**
 * 设置Default返回
 */
-(void)setupLeftButton{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 22, 22)];
    [button setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    //[button setBackgroundImage:[UIImage imageNamed:@"back_button_sel"] forState:UIControlStateHighlighted];
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    if (iOS7) {
        //iOS7 custom leftBarButtonItem 偏移
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -10;
        self.navigationItem.leftBarButtonItems = @[negativeSpacer, btnItem];
    }else{
        self.navigationItem.leftBarButtonItem = btnItem;
        
    }
    [button addTarget:self action:@selector(leftBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
}

/**
 * 设置自定义Nav左侧按钮
 */
-(void)setLeftBtnWithImage:(NSDictionary *)imageName
{
    //设置navigationbar左边按钮
    NSString *nomarlName = [imageName objectForKey:@"nomarl"];
    NSString *selectName = [imageName objectForKey:@"highlight"];
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0,0,22,22)];
    [leftButton setBackgroundImage:[UIImage imageNamed:nomarlName] forState:UIControlStateNormal];
    [leftButton setBackgroundImage:[UIImage imageNamed:selectName] forState:UIControlStateHighlighted];
    [leftButton addTarget:self action:@selector(leftBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBtnItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftBtnItem;
}

/**
 * 设置自定义Nav右侧按钮
 */
-(void)setRigthBarWithDic:(NSDictionary *)dictionary
{
    NSArray *imageArray = [dictionary objectForKey:@"images"];
    NSArray *selectImageArray = [dictionary objectForKey:@"imageshover"];
    NSMutableArray *btnArray = [NSMutableArray array];
    for (int i = 0 ; i < imageArray.count; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 22, 22)];
        [button addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
        [button setBackgroundImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:selectImageArray[i]] forState:UIControlStateHighlighted];
        UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        [btnArray addObject:btnItem];
        if (iOS7) {//iOS7 custom rightBarButtonItem 偏移
            UIBarButtonItem *spaceButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
            if(imageArray.count > 1){
                spaceButtonItem.width = 15;
            }
            [btnArray addObject:spaceButtonItem];
        }
    }
    self.navigationItem.rightBarButtonItems = btnArray;
}

-(void)rightBtnClick:(id)sender
{
    
}


#pragma mark - 设置右上按钮
/**
 *  设置白色的右上按钮
 *
 *  @param title  按钮文字
 *  @param target target
 *  @param sel    selector
 *
 *  @return UIButton
 */
-(UIButton*)setRightBarButtonWithTitle:(NSString*)title withTarget:(id)target withSelector:(SEL)sel{
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 44, 44);
    [rightButton setTitle:title forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [rightButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [rightButton addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
//    rightButton.backgroundColor = [UIColor blackColor];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    if (iOS7) {//iOS7 custom rightBarButtonItem 偏移
        UIBarButtonItem *spaceButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        spaceButtonItem.width = -10;
        self.navigationItem.rightBarButtonItems = @[spaceButtonItem, rightBarButtonItem];
    }else{
        self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    }
   
    return rightButton;
}

-(void)hideReturnBtn
{
    self.navigationItem.leftBarButtonItem=nil;
    
}
#pragma mark-导航相关

/**
 *  功能:左按钮点击行为，可在子类重写此方法
 */
- (void)leftBtnClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

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

-(void)setTitleImage:(UIImage *)image
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 78, 24)];
    imageView.image = image;
    self.navigationItem.titleView = imageView;
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

- (void)showHUD:(NSString *)aMessage animated:(BOOL)animated
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:animated];
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
 *  功能:隐藏hud
 */
- (void)hideHUD:(BOOL)animated
{
    [MBProgressHUD hideHUDForView:self.view animated:animated];
}

/**
 *  功能:接口请求失败
 */
-(void)failureHideHUD{
    [self hideHUD];
    [[CMAlert sharedCMAlert] alert:@"当前网络不稳定，请检查你的网络!"];
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
