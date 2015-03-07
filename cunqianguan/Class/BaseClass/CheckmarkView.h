//
//  QBAssetsCollectionCheckmarkView.h
//  QBImagePickerController
//
//  Created by Tanaka Katsuma on 2014/01/01.
//  Copyright (c) 2014年 Katsuma Tanaka. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CheckmarkViewDelegate;
@class UICollectionViewCell;

@interface CheckmarkView : UIView

@property (nonatomic,assign) BOOL checked;

@property (nonatomic,assign) BOOL animated;

@property (nonatomic,assign) BOOL bounced;

@property (nonatomic, assign) id<CheckmarkViewDelegate> delegate;

@property (nonatomic, assign) UICollectionViewCell *assetCollectionCell;

- (void)check;
- (void)uncheck;

@end


@protocol CheckmarkViewDelegate<NSObject>
@optional

-(BOOL)checkmarkViewShouldCheck:(CheckmarkView*)checkmarkView;
-(void)checkmarkViewDidCheck:(CheckmarkView*)checkmarkView;
-(void)checkmarkViewDidUncheck:(CheckmarkView*)checkmarkView;


@end