//
//  ChangeProductVC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/27.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "ChangeProductVC.h"
#import "ProductDetailHeaderView.h"
#import "BaseSegment.h"

@interface ChangeProductVC ()<CCSegmentDelegate>
{
    BOOL _isTrueProduct;
    BaseSegment *_segment;
    UIWebView *_webView;
    UITextView *_textView;
    UIView *_tabView;
}

@end

@implementation ChangeProductVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setUpTableView];
    _isTrueProduct = YES;
    
}

-(void)viewDidDisappear:(BOOL)animated
{
    [_webView loadHTMLString:@"" baseURL:nil];
    [_webView stopLoading];
    [_webView removeFromSuperview];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
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
-(void)setUpTableView
{
    [self createTableWithStye:UITableViewStyleGrouped];
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGTH - 64);
    
    ProductDetailHeaderView *headView = [ProductDetailHeaderView headerView];
    self.tableView.tableHeaderView = headView;
    
}

#pragma mark -- UITableViewDataSource && UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 400;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        CGRect frame = [self.tableView rectForFooterInSection:section];
        frame.origin.y = 0;
        _tabView = [[UIView alloc] initWithFrame:frame];
        _textView = [[UITextView alloc] initWithFrame:frame];
        _textView.text = @"ASDASDASD";
        
        if (_isTrueProduct) {
            _webView = [[UIWebView alloc] initWithFrame:frame];
            _webView.scalesPageToFit = YES;
            [_tabView addSubview:_webView];
            
            NSURL* url = [NSURL URLWithString:@"http://www.youku.com"];
            NSURLRequest* request = [NSURLRequest requestWithURL:url];
            [_webView loadRequest:request];
            
            [_tabView insertSubview:_textView belowSubview:_webView];
        }else
        {
            [_tabView addSubview:_textView];
        }
    }
    return _tabView;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
        _segment = [[BaseSegment alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 44)];
        _segment.delegate = self;
        [cell addSubview:_segment];
        [_segment setItems:@[@"商品详情",@"兑换规则"] isShowLine:NO WithSelectPlace:ShowSelectPlaceFromBottom];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)selectIndex:(NSInteger)index
{
    if (_isTrueProduct) {
        switch (index) {
            case 0:
                [_tabView bringSubviewToFront:_webView];
                break;
            case 1:
                [_tabView bringSubviewToFront:_textView];
                break;
            default:
                break;
        }
        
    }
}
@end
