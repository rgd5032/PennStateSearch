//
//  RGDBuildingViewController.m
//  Penn State Search
//
//  Created by ROBERT GERALD DICK on 10/8/13.
//  Copyright (c) 2013 ROBERT GERALD DICK. All rights reserved.
//

#import "RGDBuildingViewController.h"

@interface RGDBuildingViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *buildings;
@end

@implementation RGDBuildingViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.tableView.dataSource = self;
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSString *path = [mainBundle pathForResource:@"buildings" ofType:@"plist"];
    _buildings = [[NSArray alloc] initWithContentsOfFile:path];
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    NSArray *array = [[NSArray alloc] initWithObjects:descriptor, nil];
    self.buildings = [self.buildings sortedArrayUsingDescriptors:array];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.buildings.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = [self.buildings[indexPath.row] objectForKey:@"name"];
    
    if([[self.buildings[indexPath.row] objectForKey:@"photo"] isEqualToString:@""]){
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    else{
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}

//#pragma mark - Segues
//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if ([segue.identifier isEqualToString:@"DetailSegue"]) {
//        RGDDetailViewController *detailViewController = segue.destinationViewController;
//        detailViewController.model = self.model;
//        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//        detailViewController.resultIndex = indexPath.row;
//    }
//}

@end
