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
#import "ExChangeModel.h"
#import "Constants.h"
@interface ChangeProductVC ()<CCSegmentDelegate>
{
    BOOL _isTrueProduct;
    BaseSegment *_segment;
    UIScrollView *_scrollView;
    UITextView *_textView;
    UIView *_tabView;
    ProductDetailHeaderView *_headView;
    ExChangeModel *_model;
    ExChangeDetailModel *_detailModel;
}

@end

@implementation ChangeProductVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setUpTableView];
    _isTrueProduct = YES;
    
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
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGTH - 104);
    
    _headView = [ProductDetailHeaderView headerView];
    self.tableView.tableHeaderView = _headView;
}

-(void)reloadView:(ExChangeModel *)model andDetail:(ExChangeDetailModel *)detailModel
{
    _model = model;
    _detailModel = detailModel;
    [_headView loadData:_model];
    [self.tableView reloadData];
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
        _textView.editable = NO;
        if (_detailModel.rules.count > 0) {
            NSArray *rules = _detailModel.rules[0];
            NSString *str = @"兑换说明\n";
            for (int i = 0; i < rules.count; i++) {
                NSString *rule = [NSString stringWithFormat:@"%d.%@\n",(i+1),rules[i]];
                str = [str stringByAppendingString:rule];
            }
            
            NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
            [attrStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:17.0f] range:NSMakeRange(0,4)];
            [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15.0f] range:NSMakeRange(4,str.length - 4)];
            
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.lineSpacing = 5;// 字体的行间距
            paragraphStyle.paragraphSpacing = 5;
            [attrStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, str.length)];
        
            _textView.attributedText = attrStr;
        }
        
        if (_isTrueProduct) {
            _scrollView = [[UIScrollView alloc] initWithFrame:frame];
            _scrollView.backgroundColor = [UIColor whiteColor];
            [_tabView addSubview:_scrollView];
            if (_detailModel.pics.count > 0) {
                NSArray *pics = _detailModel.pics;
                CGFloat visiableY = 0,visiableHeight = 150;
                for (int i = 0; i < pics.count; i++) {
                    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, visiableY, frame.size.width, visiableHeight)];
                    [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",shareURL,pics[i]]]];
                    [_scrollView addSubview:imageView];
                    visiableY = imageView.frame.size.height + imageView.frame.origin.y;
                }
                [_scrollView setContentSize:CGSizeMake(frame.size.width, pics.count*visiableHeight + 100)];
            }
            [_tabView insertSubview:_textView belowSubview:_scrollView];
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
                [_tabView bringSubviewToFront:_scrollView];
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
