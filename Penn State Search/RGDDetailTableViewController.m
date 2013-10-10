//
//  RGDDetailViewController.m
//  Penn State Search
//
//  Created by ROBERT GERALD DICK on 10/8/13.
//  Copyright (c) 2013 ROBERT GERALD DICK. All rights reserved.
//

#import "RGDDetailTableViewController.h"
#import "RGDSearchModel.h"

@interface RGDDetailTableViewController ()
@property (strong, nonatomic) RGDSearchModel *model;
@property (weak, nonatomic) IBOutlet UITableViewCell *nameCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *titleCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *addressLabel;
@property (weak, nonatomic) IBOutlet UITableViewCell *emailCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *numberCell;

@end

@implementation RGDDetailTableViewController

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _model = [RGDSearchModel sharedInstance];
    }
    return self;
}

-(void)viewDidLoad
{
    self.addressLabel.textLabel.numberOfLines = 0;
    self.nameCell.textLabel.text = [self.model displayNameForIndex:self.resultIndex];
    self.titleCell.textLabel.text = [self.model titleForIndex:self.resultIndex];
    self.addressLabel.textLabel.text = [self.model addressForIndex:self.resultIndex];
    self.emailCell.textLabel.text = [self.model emailForIndex:self.resultIndex];
    self.numberCell.textLabel.text = [self.model numberForIndex:self.resultIndex];
}

@end
