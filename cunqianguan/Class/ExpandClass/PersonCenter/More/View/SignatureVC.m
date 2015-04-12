//
//  RLSignatureVC.m
//  manpower
//
//  Created by WangShunzhou on 14-9-15.
//  Copyright (c) 2014年 WHZM. All rights reserved.
//

#import "SignatureVC.h"
#import "PersonInfo.h"
#import "PersonConnect.h"
#import "BaseConnect.h"
#import "BaseUtil.h"
@interface SignatureVC ()<UITextViewDelegate>
{
    PersonInfo *_info;
}
@property(nonatomic, strong) NSString *placeholder;
@property(nonatomic) NSInteger maxLength;

@property (weak, nonatomic) IBOutlet UIButton *subBtn;
@property (nonatomic) IBOutlet UITextView *textView;
@property(nonatomic, assign) IBOutlet UILabel *placeholderLabel;
@end

@implementation SignatureVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.placeholder = @"请畅所欲言，有您我们会更精彩！";
        self.maxLength = 30;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _info = [PersonInfo sharedPersonInfo];
    self.textView.layer.borderColor = [UIColorFromRGB(0x999999) CGColor];
    self.textView.layer.borderWidth = 0.5;
    self.textView.delegate = self;
    
    self.placeholderLabel.text = self.placeholder;
    
    [_subBtn setBackgroundImage:[BaseUtil imageWithColor:UIColorFromRGB(0xed4142)] forState:UIControlStateNormal];
    [_subBtn setBackgroundImage:[BaseUtil imageWithColor:UIColorFromRGB(0xd22223)] forState:UIControlStateHighlighted];
    _subBtn.layer.cornerRadius = 5.0f;
    _subBtn.layer.masksToBounds = YES;
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView)]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)submitAction:(id)sender
{
    NSString *textStr  = self.textView.text;
    [self showHUD:ACTION_LOAD];
    [[PersonConnect sharedPersonConnect] responseMsg:_info.email pws:_info.password content:textStr success:^(id json) {
        [self hideAllHUD];
        NSDictionary *dic = (NSDictionary *)json;
        [self showStringHUD:[dic objectForKey:@"info"] second:2];
        if ([BaseConnect isSucceeded:dic]) {
            _textView.text = @"";
            _subBtn.backgroundColor = [UIColor lightGrayColor];
            _subBtn.userInteractionEnabled = NO;
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSError *err) {
        [self hideAllHUD];
    }];
}

-(void)tapView
{
    [_textView resignFirstResponder];
}

#pragma mark -- UITextViewDeleagte
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text{
    if (![text isEqualToString:@""]) {
        self.placeholderLabel.hidden = YES;
    }
    
    if ([text isEqualToString:@""] && range.location == 0 && range.length == 1) {
        self.placeholderLabel.hidden = NO;
    }
    return YES;
}

@end
