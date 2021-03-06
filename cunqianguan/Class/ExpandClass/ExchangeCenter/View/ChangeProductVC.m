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
#import "UIImage+Resize.h"
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
    NSArray *_titleArray;
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
    [self createTableWithStye:UITableViewStylePlain];
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGTH - 104);
    
    _headView = [ProductDetailHeaderView headerView];
    self.tableView.tableHeaderView = _headView;
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

-(void)reloadView:(ExChangeModel *)model andDetail:(ExChangeDetailModel *)detailModel
{
    _model = model;
    _detailModel = detailModel;
    [_headView loadData:_model];
    if (_model.use_types == 1) {
        _isTrueProduct = NO;
    }
    self.tableView.tableFooterView = [self createFooterView];
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    bgView.backgroundColor = UIColorFromRGB(0xececec);
    return bgView;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 0;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    if (section == 0) {
//        CGRect frame = [self.tableView rectForFooterInSection:section];
//        frame.origin.y = 0;
//        _tabView = [[UIView alloc] initWithFrame:frame];
//        _textView = [[UITextView alloc] initWithFrame:frame];
//        _textView.editable = NO;
//        if (_detailModel.rules.count > 0) {
//            NSArray *rules = _detailModel.rules[0];
//            NSString *str = @"兑换说明\n";
//            for (int i = 0; i < rules.count; i++) {
//                NSString *rule = [NSString stringWithFormat:@"%d.%@\n",(i+1),rules[i]];
//                str = [str stringByAppendingString:rule];
//            }
//            
//            NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
//            [attrStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:17.0f] range:NSMakeRange(0,4)];
//            [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15.0f] range:NSMakeRange(4,str.length - 4)];
//            
//            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//            paragraphStyle.lineSpacing = 5;// 字体的行间距
//            paragraphStyle.paragraphSpacing = 5;
//            [attrStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, str.length)];
//        
//            _textView.attributedText = attrStr;
//        }
//        
//        if (_isTrueProduct) {
//            _scrollView = [[UIScrollView alloc] initWithFrame:frame];
//            _scrollView.backgroundColor = [UIColor whiteColor];
//            [_tabView addSubview:_scrollView];
//            if (_detailModel.pics.count > 0) {
//                NSArray *pics = _detailModel.pics;
//                CGFloat visiableY = 0,visiableHeight = 150;
//                for (int i = 0; i < pics.count; i++) {
//                    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, visiableY, frame.size.width, visiableHeight)];
//                    [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",shareURL,pics[i]]]];
//                    [_scrollView addSubview:imageView];
//                    visiableY = imageView.frame.size.height + imageView.frame.origin.y;
//                }
//                [_scrollView setContentSize:CGSizeMake(frame.size.width, pics.count*visiableHeight + 100)];
//            }
//            [_tabView insertSubview:_textView belowSubview:_scrollView];
//            //[self selectIndex:1];
//        }else
//        {
//            [_tabView addSubview:_textView];
//        }
//    }
//    return _tabView;
//}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    
    _segment = [[BaseSegment alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 44)];
    _segment.backgroundColor = [UIColor whiteColor];
    _segment.delegate = self;
    [cell.contentView addSubview:_segment];
    if (_isTrueProduct) {
        _titleArray = @[@"商品详情",@"兑换规则"];
    }else{
        _titleArray = @[@"兑换规则"];
    }
    [_segment setItems:_titleArray isShowLine:NO WithSelectPlace:ShowSelectPlaceFromBottom];
    
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

-(UIView *)createFooterView
{
    _tabView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 400)];
    CGRect frame = _tabView.frame;
    _textView = [[UITextView alloc] initWithFrame:frame];
    _textView.editable = NO;
    _textView.scrollEnabled = NO;
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
        _scrollView.delegate = self;
        _scrollView.backgroundColor = [UIColor whiteColor];
        [_tabView addSubview:_scrollView];
        if (_detailModel.pics.count > 0) {
            NSArray *pics = _detailModel.pics;
            CGFloat visiableY = 0,visiableHeight = 150;
            for (int i = 0; i < pics.count; i++) {
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, visiableY, frame.size.width, visiableHeight)];
                [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",shareURL,pics[i]]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    imageView.image = [image imageByScalingAndCroppingForSize:imageView.frame.size];
                }];
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
    return _tabView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([scrollView isKindOfClass:[UITableView class]]) {
        _scrollView.scrollEnabled = YES;
    }else{
        if (scrollView.contentOffset.y <= 0) {
            _scrollView.scrollEnabled = NO;
        }else{
            _scrollView.scrollEnabled = YES;
        }
    }
    
    CGFloat sectionHeaderHeight = 20;
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}
@end
