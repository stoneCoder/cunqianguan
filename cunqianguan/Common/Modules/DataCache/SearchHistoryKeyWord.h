//
//  OrderSearchHistoryKeyWord.h
//  Cntianran
//
//  Created by hanjin on 14-9-28.
//  Copyright (c) 2014年 INMEDIA. All rights reserved.
//

#import <Foundation/Foundation.h>
#define SEARCH_ORDER_HISTORY_KEYWORD @"SEARCH_ORDER_HISTORY_KEYWORD"

@interface SearchHistoryKeyWord : NSObject
DEFINE_SINGLETON_FOR_HEADER(SearchHistoryKeyWord)
-(NSMutableArray *)currentHistoryKeyWordList;
-(void)saveHistoryKeyWordList:(NSMutableArray *)list;
@end
