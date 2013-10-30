//
//  RGDBuildingInfoViewController.m
//  Penn State Search
//
//  Created by ROBERT GERALD DICK on 10/29/13.
//  Copyright (c) 2013 ROBERT GERALD DICK. All rights reserved.
//

#import "RGDBuildingInfoViewController.h"
#import "RGDBuildingImageViewController.h"

#define kTextViewTopAndBottomMarginTotal 36

@interface RGDBuildingInfoViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation RGDBuildingInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.textView.text = self.infoString;
    self.nameLabel.text = self.buildingName;
    
    if (self.buildingImage != nil){
        self.navigationItem.rightBarButtonItems = @[self.editButtonItem, self.navigationItem.rightBarButtonItem];
    }
    else{
        self.navigationItem.rightBarButtonItems = @[self.editButtonItem];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
    
    
}

-(void)viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Notification Handlers

-(void)keyboardWasShown:(NSNotification*)notification {
    NSDictionary *info = notification.userInfo;
    CGRect frame = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGSize keyboardSize = frame.size;
    self.textView.frame = CGRectMake(self.textView.frame.origin.x, self.textView.frame.origin.y, self.textView.bounds.size.width, self.textView.frame.size.height - (keyboardSize.height - kTabBarHeight));
}

-(void)keyboardWillBeHidden:(NSNotification*)notification {
    
    self.textView.frame = CGRectMake(self.textView.frame.origin.x, self.textView.frame.origin.y, self.textView.bounds.size.width, self.view.bounds.size.height - kTextViewTopAndBottomMarginTotal);
}

-(void)updateTextView {
    self.textView.text = self.infoString;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    if (!self.editing) {
        [self.textView resignFirstResponder];
    } else {
        [self.textView becomeFirstResponder];
    }
}

#pragma mark - TextView Delegate
-(void)textViewDidBeginEditing:(UITextView *)textView {
    if (!self.editing) {
        [self setEditing:YES animated:YES];
    }
}

-(void)textViewDidEndEditing:(UITextView *)textView {
    self.completionBlock(self.textView.text);
}

//#pragma mark - Splitview delegate
//-(void)splitViewController:(UISplitViewController *)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)pc {
//    
//    barButtonItem.title = @"States";
//    [self.navigationItem setLeftBarButtonItem:barButtonItem];
//}
//
//-(void)splitViewController:(UISplitViewController *)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem   {
//    [self.navigationItem setLeftBarButtonItem:nil];
//}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"BuildingImageSegue"]) {
        RGDBuildingImageViewController *buildingImageViewController = segue.destinationViewController;
        buildingImageViewController.image = self.buildingImage;
        buildingImageViewController.imageTitle = self.buildingName;
        buildingImageViewController.completionBlock = ^(id obj){
            [self dismissViewControllerAnimated:true completion:NULL];
        };

    }
}


@end
