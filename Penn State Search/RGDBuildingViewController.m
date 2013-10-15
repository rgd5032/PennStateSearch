//
//  RGDBuildingViewController.m
//  Penn State Search
//
//  Created by ROBERT GERALD DICK on 10/8/13.
//  Copyright (c) 2013 ROBERT GERALD DICK. All rights reserved.
//

#import "RGDBuildingViewController.h"
#import "RGDBuildingModel.h"
#import "RGDBuildingImageViewController.h"
#import "RGDPreferencesViewController.h"
#import "kConstants.h"

@interface RGDBuildingViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) RGDBuildingModel *model;
@property BOOL listOnlyBuildingsWithImages;
@end

@implementation RGDBuildingViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.tableView.dataSource = self;
    _model = [RGDBuildingModel sharedInstance];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    NSNumber *boolNumber = [preferences objectForKey:kShowOnlyBuildingsWithImages];
    self.listOnlyBuildingsWithImages = [boolNumber boolValue];
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (self.listOnlyBuildingsWithImages){
        return [self.model buildingsWithImagesCount];
    }
    
    return [self.model buildingCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    static NSString *DisclosureCellIdentifier = @"CellWithDisclosure";
    UITableViewCell *cell;
    NSInteger index = indexPath.row;
    
    if (self.listOnlyBuildingsWithImages){
        index = [self.model indexForNextBuildingWithImageStartingAtIndex:index];
    }
    
    if(self.listOnlyBuildingsWithImages || [self.model imageExistsForBuildingWithIndex:index]){
         cell = [tableView dequeueReusableCellWithIdentifier:DisclosureCellIdentifier forIndexPath:indexPath];
    }
    else{
         cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    }
    
    // Configure the cell...
    cell.textLabel.text = [self.model buildingNameForIndex:index];
    
    return cell;
}

#pragma mark - Segues
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"BuildingImageSegue"]) {
        RGDBuildingImageViewController *buildingImageViewController = segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSInteger index = indexPath.row;
        if (self.listOnlyBuildingsWithImages){
            index = [self.model indexForNextBuildingWithImageStartingAtIndex:index];
        }
        buildingImageViewController.buildingIndex = index;
    }
}

@end
