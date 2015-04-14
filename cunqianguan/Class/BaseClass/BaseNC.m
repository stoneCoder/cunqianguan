//
//  BaseNC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/19.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "BaseNC.h"
#import "BaseUtil.h"
#import <QuartzCore/QuartzCore.h>
/*window窗口
#define WINDOW  [[UIApplication sharedApplication] keyWindow]
#define SCREEN_VIEW_WIDTH  self.view.bounds.size.width

static const float kDurationTime = 0.3;
static const float kScaleValue = 0.95;*/

@interface BaseNC ()
/*{
    CGPoint startTouch; //拖动开始时位置
    BOOL isMoving;      //是否在拖动中
    
    UIView *blackMask;
    //The snapshot
    UIImageView *lastScreenShotView;
}
@property (nonatomic,retain) UIView *backgroundView;//背景
@property (nonatomic,retain) NSMutableArray *screenShotsList;//存截*/
@end

@implementation BaseNC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        /* 只少2个 头一个肯定是顶级的界面
        self.screenShotsList = [[NSMutableArray alloc]initWithCapacity:2];*/
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
    
    /*UIPanGestureRecognizer *panGesture=[[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                               action:@selector(handlePanGesture:)];
    [self.view addGestureRecognizer:panGesture];
    isMoving = NO;*/
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
/*#pragma mark -- 手势返回
- (void)checkBackgroudViewExist
{
    if (!self.backgroundView){
        CGRect frame = self.view.frame;
        self.backgroundView = [[UIView alloc] initWithFrame:frame];
        self.backgroundView.backgroundColor = [UIColor blackColor];
        //把backgroundView插入到Window视图上，并below低于self.view层
        [WINDOW insertSubview:self.backgroundView belowSubview:self.view];
        
        //在backgroundView添加黑色的面罩
        blackMask = [[UIView alloc] initWithFrame:frame];
        blackMask.backgroundColor = [UIColor blackColor];
        [self.backgroundView addSubview:blackMask];
    }
    self.backgroundView.hidden = NO;
}

- (void)addLastScreenShotView
{
    if (lastScreenShotView) [lastScreenShotView removeFromSuperview];
    
    UIImage *lastScreenShot = [self.screenShotsList lastObject];
    //把截图插入到backgroundView上，并黑色的背景下面
    lastScreenShotView = [[UIImageView alloc]initWithImage:lastScreenShot];
    [self.backgroundView insertSubview:lastScreenShotView belowSubview:blackMask];
}

- (IBAction)handlePanGesture:(UIGestureRecognizer*)sender
{
    //顶级 controller 则不执行返回
    if(self.viewControllers.count <= 1){
        return;
    }
    //得到触摸中在window上拖动的过程中的xy坐标
    CGPoint translation = [sender locationInView:WINDOW];
    
    if(sender.state == UIGestureRecognizerStateEnded){
        isMoving = NO;
        
        //如果结束坐标大于开始坐标50像素就动画效果移动
        if (translation.x - startTouch.x > 50) {
            [UIView animateWithDuration:kDurationTime animations:^{
                //将 self.view 移动320并缩放
                [self moveViewWithX:SCREEN_VIEW_WIDTH];
            } completion:^(BOOL finished) {
                [self gesturePopViewControllerAnimated:NO];
                //将 self.view 的 x 坐标重置为0
                CGRect frame = self.view.frame;
                frame.origin.x = 0;
                self.view.frame = frame;
            }];
        }else{
            //不大于50时就移动原位
            [UIView animateWithDuration:kDurationTime animations:^{
                [self moveViewWithX:0];
            } completion:^(BOOL finished) {
                self.backgroundView.hidden = YES;
            }];
        }
    }else if(sender.state == UIGestureRecognizerStateBegan){
        startTouch = translation;
        isMoving = YES;
        
        [self checkBackgroudViewExist];
        
        [self addLastScreenShotView];
    }
    if (isMoving) {
        [self moveViewWithX:translation.x - startTouch.x];
    }
}
- (void)moveViewWithX:(float)x
{
    x = x > SCREEN_VIEW_WIDTH ? SCREEN_VIEW_WIDTH : x;
    x = x < 0 ? 0 : x;
    
    CGRect frame = self.view.frame;
    frame.origin.x = x;
    self.view.frame = frame;
    
    float scale = (x / 6400) + kScaleValue;//缩放大小
    float alpha = 0.4 - (x / 800);//透明值
    
    //缩放scale
    if (_isScale) {
        lastScreenShotView.transform = CGAffineTransformMakeScale(scale, scale);
    }
    //背景颜色透明值
    blackMask.alpha = alpha;
}

- (UIImage *)ViewRenderImage
{
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, self.view.opaque, 0.0);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (animated) {
        //图像数组中存放一个当前的界面图像，然后再push
        [self.screenShotsList addObject:[self ViewRenderImage]];
        
        if([[self viewControllers] count] > 0){ //作为rootViewController的时候不用animated
            
            [self checkBackgroudViewExist];
            [self addLastScreenShotView];
            
            blackMask.alpha = 0;
            UIView *toView = [viewController view];
            [self.view addSubview:toView];
            
            CGRect frame = self.view.frame;
            frame.origin.x = SCREEN_VIEW_WIDTH;
            self.view.frame = frame;
            
            [UIView animateWithDuration:kDurationTime animations:^{
                [self moveViewWithX:0];
            } completion:^(BOOL finished) {
                [super pushViewController:viewController animated:NO];
            }];
            [super pushViewController:viewController animated:animated];
        }else{
            [super pushViewController:viewController animated:animated];
        }
    }else{
        [super pushViewController:viewController animated:animated];
    }
}

- (UIViewController *)gesturePopViewControllerAnimated:(BOOL)animated
{
    [self.screenShotsList removeLastObject];
    return [super popViewControllerAnimated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    UIViewController *popVC = nil;
    if (animated) {
        [self checkBackgroudViewExist];
        
        [self addLastScreenShotView];
        //先缩放 kScaleValue
        if (_isScale) {
            lastScreenShotView.transform = CGAffineTransformMakeScale(kScaleValue, kScaleValue);
        }
        [UIView animateWithDuration:kDurationTime animations:^{
            [self moveViewWithX:SCREEN_VIEW_WIDTH];
        } completion:^(BOOL finished) {
            [super popViewControllerAnimated:NO];
            CGRect frame = self.view.frame;
            frame.origin.x = 0;
            self.view.frame = frame;
            self.backgroundView.hidden = YES;
            [self.screenShotsList removeLastObject];
        }];
        popVC = [self.viewControllers lastObject];
    }else{
        popVC = [super popViewControllerAnimated:NO];
    }
    return popVC;
}*/
@end
