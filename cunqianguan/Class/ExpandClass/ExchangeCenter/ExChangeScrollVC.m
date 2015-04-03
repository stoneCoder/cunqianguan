//
//  ExChangeScrollVC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/2/4.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "ExChangeScrollVC.h"
#import "BaseSegment.h"
#import "ExChangeCenterVC.h"
#import "BaseSelectView.h"

#import "PersonInfo.h"
#import "BaseUtil.h"
#import "ExChangeConnect.h"
#import "BaseConnect.h"
#import "ExChangeAttrListModel.h"

@interface ExChangeScrollVC ()<CCSegmentDelegate,UIScrollViewDelegate,BaseSelectViewDelegate>
{
    PersonInfo *_info;
    ExChangeAttrListModel *_listModel;
    BaseSegment *_segment;
    NSArray *_titleArray;
    UIScrollView *_scrollView;
    NSInteger _currentIndex;
    NSInteger _category;
    NSInteger _btnSelectIndex;
    BaseSelectView *_selectView;
}

@end

@implementation ExChangeScrollVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _info = [PersonInfo sharedPersonInfo];
    _titleArray = @[@"我能兑换",@"全部商品"];
    [self setUpNavBar:@"筛选"];
    [self setUpSegment];
    [self setupScrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)setUpNavBar:(NSString *)aTitle
{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectZero];
    CGRect btnFrame;
    NSString * btnTitleStr=aTitle;
    if (btnTitleStr.length > 0) {
        btnTitleStr = [NSString stringWithFormat:@"%@",aTitle];
        float width = [BaseUtil getWidthByString:btnTitleStr font:button.titleLabel.font allheight:22 andMaxWidth:200];
        btnFrame = CGRectMake(0,0,22 + width +50,22);
    }else{
        btnFrame = CGRectMake(0,0,22,22);
    }
    [button setFrame:btnFrame];
    [button setImage:[UIImage imageNamed:@"shaixuan"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"shaixuan_down"] forState:UIControlStateHighlighted];
    [button setTitle:btnTitleStr forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:btnTitleStr forState:UIControlStateHighlighted];
    [button setTitleColor:UIColorFromRGB(0x1a9c92) forState:UIControlStateHighlighted];
    button.titleLabel.font=[UIFont boldSystemFontOfSize:17.0];
    button.imageEdgeInsets = UIEdgeInsetsMake(0, btnFrame.size.width - 22, 0, 0);
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    if (iOS7) {//iOS7 custom leftBarButtonItem 偏移
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -10;
        self.navigationItem.rightBarButtonItems = @[negativeSpacer, btnItem];
    }else{
        self.navigationItem.rightBarButtonItem = btnItem;
        
    }
    [button addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];

}

-(void)setUpSegment
{
    _segment = [[BaseSegment alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 44)];
    _segment.backgroundColor = [UIColor whiteColor];
    _segment.layer.shadowOpacity = 5;
    [_segment setItems:_titleArray isShowLine:NO WithSelectPlace:ShowSelectPlaceFromBottom];
    _segment.delegate = self;
    [self.view addSubview:_segment];
}

-(void)setUpSelectView:(NSArray *)btnArray
{
    
    _selectView = [[BaseSelectView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, SCREEN_HEIGTH)];
    [_selectView initView:btnArray andVisiableY:64];
    _selectView.delegate = self;
    [_selectView setSelectIndex:_btnSelectIndex];
    [_selectView setHidden:YES];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:_selectView];
    //[self.view insertSubview:_selectView aboveSubview:_scrollView];
}


-(void)setupScrollView
{
    CGFloat visiableY = _segment.frame.size.height;
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, visiableY, VIEW_WIDTH, VIEW_HEIGHT - visiableY - 64)];
    _scrollView.delegate = self;
    [_scrollView setContentSize:CGSizeMake(VIEW_WIDTH *[_titleArray count], VIEW_HEIGHT - visiableY - 64)];
    [_scrollView setPagingEnabled:YES];
    [_scrollView setShowsHorizontalScrollIndicator:NO];
    [self.view addSubview:_scrollView];
    
    for (int i = 0; i < _titleArray.count; i++) {
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        [flowLayout setSectionInset:UIEdgeInsetsMake(10, 10, 0, 10)];
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 10.0;
        
        ExChangeCenterVC *exchangeCenterVC = [[ExChangeCenterVC alloc] initWithCollectionViewLayout:flowLayout];
        [self addChildViewController:exchangeCenterVC];
        exchangeCenterVC.view.frame = CGRectMake(i*VIEW_WIDTH, 0, VIEW_WIDTH, _scrollView.frame.size.height);
        [_scrollView addSubview:exchangeCenterVC.view];
    }
    [[self childViewControllers][0] viewDidCurrentView:0 andCategroy:_category];
}

-(void)rightBtnClick:(id)sender
{
    if (!_selectView) {
        [[ExChangeConnect sharedExChangeConnect] getExchangeCateArr:_info.userId success:^(id json) {
            NSDictionary *dic = (NSDictionary *)json;
            if ([BaseConnect isSucceeded:dic]) {
                _listModel = [[ExChangeAttrListModel alloc] initWithDictionary:dic error:nil];
                NSMutableArray *titleArr = [NSMutableArray array];
                NSArray *dataArr = _listModel.data;
                for (int i = 0; i < dataArr.count; i++) {
                    ExChangeAttr *attr = (ExChangeAttr *)dataArr[i];
                    [titleArr addObject:attr.name];
                }
                [self setUpSelectView:titleArr];
                [_selectView showView];
            }
        } failure:^(NSError *err) {
            
        }];
    }else{
        [_selectView showView];
    }
}

#pragma mark -- CCSegmentDelegate
-(void)selectIndex:(NSInteger)index
{
    if (_currentIndex == index) {
        return;
    }
    [_scrollView scrollRectToVisible:CGRectMake(index*VIEW_WIDTH, 0, VIEW_WIDTH, VIEW_HEIGHT) animated:YES];
    
    _currentIndex = index;
    [[self childViewControllers][index] viewDidCurrentView:index andCategroy:_category];
}

#pragma mark -- BaseSelectViewDelegate
-(void)selectBtn:(NSInteger)index
{
    if (_btnSelectIndex == index) {
        return;
    }
    NSArray *data = _listModel.data;
    ExChangeAttr *attr = data[index];
    _category = [attr.attrId integerValue];
    _btnSelectIndex = index;
    [[self childViewControllers][_currentIndex] viewDidCurrentView:_currentIndex andCategroy:_category];
    if ([attr.name isEqualToString:@"全部"]) {
        [self setUpNavBar:@"筛选"];
    }else{
        [self setUpNavBar:attr.name];
    }
    
}

#pragma mark -- UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x/VIEW_WIDTH;
    [_segment setSelectIndex:index];
    [self selectIndex:index];
}

@end
