//
//  SMNavigationItem.h
//  SmartXHSD
//
//  Created by 左德彪 on 14-3-18.
//  Copyright (c) 2014年 com.fezo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMBarButtonItem.h"
#import "SMViewController.h"
#import "SMNavigationController.h"

// UINavigationItem

@class SMNavigationBar;

@interface SMNavigationItem : NSObject{
@private
    SMNavigationBar *_navigationBar; // the owner is SMNavigationItem
}

@property(nonatomic,retain) SMBarButtonItem *leftBarButtonItem;
@property(nonatomic,retain) SMBarButtonItem *rightBarButtonItem;

@property(strong, nonatomic) UIView *titleView;

@end

