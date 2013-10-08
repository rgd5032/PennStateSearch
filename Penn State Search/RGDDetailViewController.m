//
//  RGDDetailViewController.m
//  Penn State Search
//
//  Created by ROBERT GERALD DICK on 10/8/13.
//  Copyright (c) 2013 ROBERT GERALD DICK. All rights reserved.
//

#import "RGDDetailViewController.h"

@interface RGDDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *mailLabel;
@property (weak, nonatomic) IBOutlet UILabel *affiliationLabel;

@end

@implementation RGDDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSString *affiliation = [self.model addressForIndex:self.resultIndex];
    affiliation = [NSString stringWithFormat:@"(%@)",affiliation];
    
    self.nameLabel.text = [self.model displayNameForIndex:self.resultIndex];
    self.addressLabel.text = [self.model addressForIndex:self.resultIndex];
    [self.addressLabel sizeToFit];
    self.mailLabel.text = [self.model emailForIndex:self.resultIndex];
    self.affiliationLabel.text = [self.model affiliationForIndex:self.resultIndex];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
