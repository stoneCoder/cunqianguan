//
//  SearchViewVC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/3/13.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "SearchViewVC.h"
#import "SBSearchBar.h"
#import "SearchViewCell.h"
#import "LocalWebVC.h"
#import "HotDetailShopVC.h"

#import "BaseUtil.h"
#import "Constants.h"
#import "PersonInfo.h"
#import "HomeConnect.h"
#import "BaseConnect.h"

#import "SearchHistoryKeyWord.h"
@interface SearchViewVC ()<SBSearchBarDelegate,SearchViewCellDelegate>
{
    SBSearchBar* _searchBar;
    PersonInfo *_info;
    NSMutableArray *_data;
}

@end
static NSString *SearchCellID = @"SearchViewCell";
@implementation SearchViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _info = [PersonInfo sharedPersonInfo];
    _data = [NSMutableArray array];
    [self setUpNav];
    [self setUpTipView];
    [self setUpTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUpNav
{
    _searchBar = [[SBSearchBar alloc]initWithFrame:CGRectMake(3, 2, SCREEN_WIDTH - 55,30)];
    _searchBar.delegate = self;

    UIView *searchView = [[UIView alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH - 55, 30)];
    searchView.backgroundColor = [UIColor whiteColor];
    searchView.layer.cornerRadius = 5.0f;
    [searchView addSubview:_searchBar];
    
    self.navigationItem.titleView = searchView;
}

-(void)setUpTipView
{
    _tipView.backgroundColor = self.view.backgroundColor;
    _firstView.layer.cornerRadius = 5.0f;
    _firstView.layer.masksToBounds = YES;
    _secondView.layer.cornerRadius = 5.0f;
    _secondView.layer.masksToBounds = YES;
    _thirdView.layer.cornerRadius = 5.0f;
    _thirdView.layer.masksToBounds = YES;
    
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 3;// 字体的行间距
    
    _firstLabel.numberOfLines = 0;
    _firstLabel.lineBreakMode = NSLineBreakByCharWrapping;
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:_firstLabel.text];
    [attrStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, _firstLabel.text.length)];
    _firstLabel.attributedText = attrStr;
    
    _secondLabel.numberOfLines = 0;
    _secondLabel.lineBreakMode = NSLineBreakByCharWrapping;
    NSMutableAttributedString *secondAttrStr = [[NSMutableAttributedString alloc] initWithString:_secondLabel.text];
    [secondAttrStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, _secondLabel.text.length)];
    _secondLabel.attributedText = secondAttrStr;
    
    _thirdLabel.numberOfLines = 0;
    _thirdLabel.lineBreakMode = NSLineBreakByCharWrapping;
    NSMutableAttributedString *thirdAttrStr = [[NSMutableAttributedString alloc] initWithString:_thirdLabel.text];
    [thirdAttrStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, _thirdLabel.text.length)];
    _thirdLabel.attributedText = thirdAttrStr;
    
    
    [_tipBtn setBackgroundImage:[BaseUtil imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [_tipBtn setBackgroundImage:[BaseUtil imageWithColor:UIColorFromRGB(0xebebeb)] forState:UIControlStateHighlighted];
    _tipBtn.layer.borderWidth = 0.5f;
    _tipBtn.layer.borderColor = UIColorFromRGB(0xcecece).CGColor;
    _tipBtn.layer.cornerRadius = 5.0f;
    _tipBtn.layer.masksToBounds = YES;
}

-(void)setUpTableView
{
    [self createTableWithStye:UITableViewStylePlain];
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGTH - 64);
    self.tableView.hidden = YES;
    UINib *cellNib = [UINib nibWithNibName:@"SearchViewCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:SearchCellID];
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    
    [_data addObjectsFromArray:[[SearchHistoryKeyWord sharedSearchHistoryKeyWord] currentHistoryKeyWordList]];
    if (_data.count > 0) {
        _tipView.hidden = YES;
        self.tableView.hidden = NO;
        [self.tableView reloadData];
    }
}

- (IBAction)btnAction:(id)sender {
    LocalWebVC *loaclWebVC = [[LocalWebVC alloc] init];
    loaclWebVC.leftTitle = @"帮助中心";
    loaclWebVC.loadType = 0;
    [self.navigationController pushViewController:loaclWebVC animated:YES];
}

-(void)loadDataWith:(NSString *)text
{
    [[HomeConnect sharedHomeConnect] searchByText:text success:^(id json) {
        NSDictionary *dic = (NSDictionary *)json;
        if (dic.count > 0) {
            [_data removeAllObjects];
            //[_searchBar.searchTextField resignFirstResponder];
            [_data addObjectsFromArray:[dic objectForKey:@"result"]];
            self.tableView.hidden = NO;
            [self.tableView reloadData];
        }
    } failure:^(NSError *err) {
    }];
}

-(void)saveHistory:(NSString *)text
{
    NSMutableArray *historyData = [NSMutableArray array];
    [historyData addObjectsFromArray:[[SearchHistoryKeyWord sharedSearchHistoryKeyWord] currentHistoryKeyWordList]];
    [historyData addObject:text];
    [[SearchHistoryKeyWord sharedSearchHistoryKeyWord] saveHistoryKeyWordList:historyData];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark -- UITableViewDataSource && UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearchViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SearchCellID forIndexPath:indexPath];
    if ([_data[indexPath.row] isKindOfClass:[NSArray class]]) {
        NSArray *cellData = _data[indexPath.row];
        [cell loadDataWithArray:cellData];
    }else if ([_data[indexPath.row] isKindOfClass:[NSString class]]){
        NSString *resultStr = _data[indexPath.row];
        [cell loadDataWithText:resultStr];
    }
    cell.delegate = self;
    cell.tag = indexPath.row;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *url;
    NSString *resultStr;
    if ([_data[indexPath.row] isKindOfClass:[NSArray class]]) {
        NSArray *cellData = _data[indexPath.row];
        resultStr = cellData[0];
        url = SEARCH_URL(resultStr,MM,_info.userId);
    }else if ([_data[indexPath.row] isKindOfClass:[NSString class]]){
        resultStr = _data[indexPath.row];
        url = SEARCH_URL(resultStr,MM,_info.userId);
    }
    [self saveHistory:resultStr];
    [self pushToWeb:url];
}

-(void)pushToWeb:(NSString *)url
{
    HotDetailShopVC *hotDetailShopVC = [[HotDetailShopVC alloc] init];
    hotDetailShopVC.leftTitle = @"购物";
    hotDetailShopVC.urlPath = url;
    [self.navigationController pushViewController:hotDetailShopVC animated:YES];
}

#pragma mark -- SBSearchBarDelegate
- (void)searchAction:(SBSearchBar *)searchBar
{
    [searchBar.searchTextField resignFirstResponder];
    NSString *searchText = searchBar.text;
    if (searchText.length == 0) {
        [self showStringHUD:@"请填写查询条件" second:2];
        return;
    }
    [self saveHistory:searchText];
    NSString *url = SEARCH_URL(searchText,MM,_info.userId);
    [self pushToWeb:url];
}

- (BOOL)SBSearchBarShouldBeginEditing:(SBSearchBar *)searchBar
{
    return YES;
}

- (void)SBSearchBarTextDidBeginEditing:(SBSearchBar *)searchBar
{
    
}

- (BOOL)SBSearchBarShouldEndEditing:(SBSearchBar *)searchBar
{
    return YES;
}

- (void)SBSearchBarTextDidEndEditing:(SBSearchBar *)searchBar
{
    
}

- (BOOL)SBSearchBarChangeCharacters:(NSString *)text
{
    if (text.length > 0) {
        [self loadDataWith:text];
    }
    return YES;
}

-(void)SBSearchBarSearchButtonClicked:(SBSearchBar *)searchBar
{
    [searchBar.searchTextField resignFirstResponder];
    [self searchAction:searchBar];
}

#pragma mark -- SearchViewCellDelegate
-(void)deleteAction:(SearchViewCell *)cell
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    NSArray *array = [NSArray arrayWithObjects:indexPath, nil];
    [_data removeObjectAtIndex:cell.tag];
    [self.tableView deleteRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationLeft];
    [self.tableView reloadData];
    [[SearchHistoryKeyWord sharedSearchHistoryKeyWord] saveHistoryKeyWordList:_data];
    if (_data.count == 0) {
        self.tableView.hidden = YES;
        _tipView.hidden = NO;
    }
}
@end
