//
//  RGDViewController.m
//  Penn State Search
//
//  Created by ROBERT GERALD DICK on 10/1/13.
//  Copyright (c) 2013 ROBERT GERALD DICK. All rights reserved.
//

#import "RGDViewController.h"
#import "Model.h"

#define kAccessIDTextFieldTag 2
#define kKeyboardPortaitHeight 216

@interface RGDViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) Model *model;

@end

@implementation RGDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _model = [[Model alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField.tag == kAccessIDTextFieldTag)
    {
        UIEdgeInsets edgeInsets = UIEdgeInsetsMake(0, 0, kKeyboardPortaitHeight, 0);
        [self.scrollView setContentInset:edgeInsets];
        [self.scrollView setContentOffset:CGPointMake(0, kKeyboardPortaitHeight)];
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [self.scrollView setContentInset:UIEdgeInsetsZero];
    [self.scrollView setContentOffset:CGPointZero];
}

@end
