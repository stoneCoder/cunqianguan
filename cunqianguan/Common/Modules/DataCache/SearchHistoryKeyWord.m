//
//  OrderSearchHistoryKeyWord.m
//  Cntianran
//
//  Created by hanjin on 14-9-28.
//  Copyright (c) 2014年 INMEDIA. All rights reserved.
//

#import "SearchHistoryKeyWord.h"
#import "ACUtilities.h"

@implementation SearchHistoryKeyWord
DEFINE_SINGLETON_FOR_CLASS(SearchHistoryKeyWord)
-(NSMutableArray *)currentHistoryKeyWordList{
    NSMutableArray * list=[NSKeyedUnarchiver unarchiveObjectWithFile:ac_PathInCachesDirectory(SEARCH_ORDER_HISTORY_KEYWORD)];
    return list;
}
-(void)saveHistoryKeyWordList:(NSMutableArray *)list{
    [NSKeyedArchiver archiveRootObject:list toFile:ac_PathInCachesDirectory(SEARCH_ORDER_HISTORY_KEYWORD)];
}
@end
