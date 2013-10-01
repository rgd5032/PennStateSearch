//
//  RGDSearchViewController.m
//  Penn State Search
//
//  Created by ROBERT GERALD DICK on 10/1/13.
//  Copyright (c) 2013 ROBERT GERALD DICK. All rights reserved.
//

#import "RGDSearchViewController.h"

@interface RGDSearchViewController ()

- (IBAction)dismissButtonPressed:(id)sender;

@end

@implementation RGDSearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}


- (IBAction)dismissButtonPressed:(id)sender {
    [self.delegate dismissMe];
}
@end
