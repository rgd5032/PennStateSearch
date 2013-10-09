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
@property (weak, nonatomic) IBOutlet UITableView *tableView;

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

//-(void)viewDidLoad
//{
//    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"NameCell" forIndexPath:0];
//    cell.textLabel.text = @"Me";
//}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    
    return cell;
}

@end
