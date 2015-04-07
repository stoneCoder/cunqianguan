//
//  InviteVC.m
//  cunqianguan
//
//  Created by 四三一八 on 15/1/30.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import "InviteVC.h"
#import "InviteRewardVC.h"
#import "PersonInfo.h"
#import "PersonConnect.h"
#import "BaseConnect.h"
#import "ShareUtil.h"
#import "BaseUtil.h"
#import "RankingListView.h"
#import "RankingListModel.h"
@interface InviteVC ()
{
    PersonInfo *_info;
    RankingListView *_rankingListView;
    RankingListModel *_listModel;
}

@end

@implementation InviteVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setUpBtn];
    _info = [PersonInfo sharedPersonInfo];

    _pointLabel.text = @"注：当用户通过您的邀请链接访问保鲜期网后，只要在7天内注册，均为有效。";
    _pointLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _pointLabel.numberOfLines = 0;
    
    _rankingListView = [[RankingListView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [_scrollView addSubview:_rankingListView];
    
    [self loadDataWith:_info.userId andType:0];
    [self loadRankingViewData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUpBtn
{
    [_inviteBtn setBackgroundImage:[BaseUtil imageWithColor:UIColorFromRGB(0x2db8ad)] forState:UIControlStateNormal];
    [_inviteBtn setBackgroundImage:[BaseUtil imageWithColor:UIColorFromRGB(0x179a90)] forState:UIControlStateHighlighted];
    _inviteBtn.layer.cornerRadius = 5.0f;
    _inviteBtn.layer.masksToBounds = YES;
    
    [_watchInviteBtn setBackgroundImage:[BaseUtil imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [_watchInviteBtn setBackgroundImage:[BaseUtil imageWithColor:UIColorFromRGB(0xebebeb)] forState:UIControlStateHighlighted];
    _watchInviteBtn.layer.borderWidth = 0.5f;
    _watchInviteBtn.layer.borderColor = UIColorFromRGB(0xcecece).CGColor;
    _watchInviteBtn.layer.cornerRadius = 5.0f;
    _watchInviteBtn.layer.masksToBounds = YES;
}

-(void)viewDidLayoutSubviews
{
    CGFloat height = _rankingListView.frame.size.height;
    if (IS_IOS7 && height >0) {
        CGSize size = _scrollView.contentSize;
        CGFloat contentHeight = size.height + height + 20;
        _scrollView.contentSize = CGSizeMake(_scrollView.contentSize.width, contentHeight);
    }
}

-(void)loadRankingViewData
{
    [[PersonConnect sharedPersonConnect] getInviteBang:[NSDictionary dictionary] success:^(id json) {
        NSDictionary *dic = (NSDictionary *)json;
        if ([BaseConnect isSucceeded:dic]) {
            _listModel = [[RankingListModel alloc] initWithDictionary:dic error:nil];
            CGFloat height = ([_listModel.data count] +1)*44;
            _rankingListView.frame = CGRectMake(16, _pointLabel.frame.size.height+_pointLabel.frame.origin.y+20, SCREEN_WIDTH - 32, height - 5);
            [_rankingListView setUpTable:_listModel.data];
            
            CGSize size = _scrollView.contentSize;
            CGFloat contentHeight = size.height + height + 20;
            _scrollView.contentSize = CGSizeMake(_scrollView.contentSize.width, contentHeight);
        }
    } failure:^(NSError *err) {
        
    }];
}

-(void)loadDataWith:(NSString *)userId andType:(NSInteger)type
{
    [self showHUD:DATA_LOAD];
    [[PersonConnect sharedPersonConnect] getUserInvite:_info.userId page:1 success:^(id json) {
        [self hideAllHUD];
        NSDictionary *dic = (NSDictionary *)json;
        if ([BaseConnect isSucceeded:dic]) {
            NSDictionary *data  = [dic objectForKey:@"data"];
            NSString  *inviteUrl = [data objectForKey:@"invite_url"];
            if (type == 1) {
                [ShareUtil presentInviteView:self content:inviteUrl image:[UIImage imageNamed:@"sharereward"]];
            }else{
                NSNumber *fanliTotle = [data objectForKey:@"fanlimoneyTotal"];
                if (![fanliTotle isEqual:[NSNull null]]) {
                    _totelMoneyLabel.text = [[NSString alloc] initWithFormat:@"%@",fanliTotle];
                }
                NSNumber *userTotle = [data objectForKey:@"userTotal"];
                if (![userTotle isEqual:[NSNull null]] && userTotle != nil) {
                    _totelInviteLabel.text = [[NSString alloc] initWithFormat:@"%@",userTotle];
                }
                
            }
        }
    } failure:^(NSError *err) {
        [self hideAllHUD];
    }];
}

- (IBAction)inviteAction:(id)sender
{
    [self loadDataWith:_info.userId andType:1];
}

- (IBAction)watchInviteReword:(id)sender
{
    InviteRewardVC *inviteRewardVC = [[InviteRewardVC alloc] init];
    inviteRewardVC.leftTitle = @"查看邀请奖励";
    [self.navigationController pushViewController:inviteRewardVC animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
