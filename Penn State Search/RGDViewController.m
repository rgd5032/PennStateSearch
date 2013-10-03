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
    self.scrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.scrollView setContentSize:self.view.frame.size];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.firstNameField.text = @"";
    self.lastNameField.text = @"";
    self.accessIdField.text = @"";
}

-(void)dismissMe
{
    [self dismissViewControllerAnimated:YES completion:NULL];
    [self.firstNameField resignFirstResponder];
    [self.lastNameField resignFirstResponder];
    [self.accessIdField resignFirstResponder];
}

#pragma mark - Text Field Functions
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(0, 0, kKeyboardPortaitHeight, 0);
    [self.scrollView setContentInset:edgeInsets];
    
    if (self.view.bounds.size.height - (textField.frame.origin.y + textField.frame.size.height) < kKeyboardPortaitHeight)
    {
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
        searchViewController.model = self.model;
    }
}

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
