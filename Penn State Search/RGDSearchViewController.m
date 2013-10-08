//
//  RGDSearchViewController.m
//  Penn State Search
//
//  Created by ROBERT GERALD DICK on 10/1/13.
//  Copyright (c) 2013 ROBERT GERALD DICK. All rights reserved.
//

#import "RGDSearchViewController.h"
#import "RGDDetailViewController.h"

@interface RGDSearchViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation RGDSearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.tableView.dataSource = self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.model count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = [self.model displayNameForIndex:indexPath.row];
    cell.detailTextLabel.text = [self.model addressForIndex:indexPath.row];
    
    return cell;
}

#pragma mark - Segues
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"DetailSegue"]) {
        RGDDetailViewController *detailViewController = segue.destinationViewController;
        detailViewController.model = self.model;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        detailViewController.resultIndex = indexPath.row;
    }
}

@end
