//
//  SBSearchBar.h
//  SBSearchBarExample
//
//  Created by Santiago Bustamante on 4/29/14.
//  Copyright (c) 2014 Busta. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SBSearchBar;

@protocol SBSearchBarDelegate <NSObject>

@optional
- (void)SBSearchBarSearchButtonClicked:(SBSearchBar *)searchBar;                     // called when keyboard search button pressed
- (void)SBSearchBarCancelButtonClicked:(SBSearchBar *)searchBar;                     // called when cancel button is pressed

- (BOOL)SBSearchBarShouldBeginEditing:(SBSearchBar *)searchBar;                      // return NO to not become first responder
- (void)SBSearchBarTextDidBeginEditing:(SBSearchBar *)searchBar;                     // called when text starts editing
- (BOOL)SBSearchBarShouldEndEditing:(SBSearchBar *)searchBar;                        // return NO to not resign first responder
- (void)SBSearchBarTextDidEndEditing:(SBSearchBar *)searchBar;                       // called when text ends editing
- (BOOL)SBSearchBarChangeCharacters:(NSString *)text;

- (void)searchAction:(SBSearchBar *)searchBar;

@end

@interface SBSearchBar : UIView <UITextFieldDelegate>

@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIImage *cancelButtonImage;
@property (nonatomic, strong) UITextField *searchTextField;
@property (nonatomic, assign) id <SBSearchBarDelegate> delegate;
@property (nonatomic, readonly) NSString *text;
@property (nonatomic, assign) UIFont *font;
@property (nonatomic, assign) UIColor *placeHolderColor;
@property (nonatomic, assign) NSString *placeHolderText;

-(void) setTextColor:(UIColor *)color;

@end
