//
//  RGDViewController.m
//  Penn State Search
//
//  Created by ROBERT GERALD DICK on 10/1/13.
//  Copyright (c) 2013 ROBERT GERALD DICK. All rights reserved.
//

#import "RGDViewController.h"
#import "RGDSearchViewController.h"
#import "RGDSearchModel.h"

#define kKeyboardPortaitHeight 216
#define kNavigationBarPortraitHeight 44

@interface RGDViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *firstNameField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameField;
@property (weak, nonatomic) IBOutlet UITextField *accessIdField;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) RGDSearchModel *model;
- (IBAction)searchPressed:(id)sender;

@end

@implementation RGDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _model = [RGDSearchModel sharedInstance];
    [self.scrollView setContentSize:self.scrollView.frame.size];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.firstNameField.text = @"";
    self.lastNameField.text = @"";
    self.accessIdField.text = @"";
}

#pragma mark - Text Field Functions
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGFloat insetOffsetDistance = kKeyboardPortaitHeight - kNavigationBarPortraitHeight;
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(0, 0, insetOffsetDistance, 0);
    [self.scrollView setContentInset:edgeInsets];
    
    if (self.scrollView.bounds.size.height - (textField.frame.origin.y + textField.frame.size.height) < insetOffsetDistance)
    {
        [self.scrollView setContentOffset:CGPointMake(0, insetOffsetDistance)];
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [self.scrollView setContentInset:UIEdgeInsetsZero];
    [self.scrollView setContentOffset:CGPointZero];
}

#pragma mark - Segues
//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if ([segue.identifier isEqualToString:@"SearchSegue"]) {
//        RGDSearchViewController *searchViewController = segue.destinationViewController;
//    }
//}

#pragma mark - IBActions
- (IBAction)searchPressed:(id)sender {
    NSString *firstName = self.firstNameField.text;
    NSString *lastName = self.lastNameField.text;
    NSString *accessId = self.accessIdField.text;
    
    if (accessId.length == 0 && lastName.length == 0){
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Invalid Entry"
                                  message:@"Please enter a Last Name and/or Access ID to complete a search."
                                  delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
    else{
        [self.model searchWithFirstName:firstName lastName:lastName accessID:accessId];
        
        if ([self.model resultsFound]){
            [self.view endEditing:YES];
            [self performSegueWithIdentifier:@"SearchSegue" sender:Nil];
        }
        else{
            
            UIAlertView *alertView = [[UIAlertView alloc]
                                    initWithTitle:@"No Results"
                                    message:@"No results were found for your search."
                                    delegate:nil
                                    cancelButtonTitle:@"OK"
                                    otherButtonTitles:nil];
            [alertView show];
        }
    }
}
    
@end
