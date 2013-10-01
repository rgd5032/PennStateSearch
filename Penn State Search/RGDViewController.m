//
//  RGDViewController.m
//  Penn State Search
//
//  Created by ROBERT GERALD DICK on 10/1/13.
//  Copyright (c) 2013 ROBERT GERALD DICK. All rights reserved.
//

#import "RGDViewController.h"
#import "RGDSearchViewController.h"
#import "RGDModel.h"

#define kAccessIDTextFieldTag 2
#define kKeyboardPortaitHeight 216

@interface RGDViewController () <UITextFieldDelegate, SearchDelegate>
@property (weak, nonatomic) IBOutlet UITextField *firstNameField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameField;
@property (weak, nonatomic) IBOutlet UITextField *accessIdField;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) RGDModel *model;
- (IBAction)searchPressed:(id)sender;

@end

@implementation RGDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _model = [[RGDModel alloc] init];
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

#pragma mark - Segues
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"SearchSegue"]) {
        RGDSearchViewController *searchViewController = segue.destinationViewController;
        searchViewController.delegate = self;
    }
}

-(void)dismissMe
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)searchPressed:(id)sender {
    [self.model searchWithFirstName:@"Robert" lastName:@"Dick" accessID:@""];
}
@end
