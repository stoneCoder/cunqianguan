//
//  SearchViewCell.h
//  cunqianguan
//
//  Created by 四三一八 on 15/3/13.
//  Copyright (c) 2015年 4318. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SearchViewCell;
@protocol SearchViewCellDelegate<NSObject>
-(void)deleteAction:(SearchViewCell *)cell;
@end
@interface SearchViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipLable;
@property (weak, nonatomic) IBOutlet UIButton *clearBtn;

@property (strong, nonatomic) id<SearchViewCellDelegate> delegate;
-(void)loadDataWithArray:(NSArray *)data;
-(void)loadDataWithText:(NSString *)text;
@end
