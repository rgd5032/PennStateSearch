//
//  RGDBuildingViewController.m
//  Penn State Search
//
//  Created by ROBERT GERALD DICK on 10/8/13.
//  Copyright (c) 2013 ROBERT GERALD DICK. All rights reserved.
//

#import "RGDBuildingViewController.h"
#import "RGDBuildingImageViewController.h"
#import "RGDBuildingInfoViewController.h"
#import "RGDPreferencesViewController.h"
#import "RGDAddBuildingTableViewController.h"
#import "kConstants.h"
#import "MyDataManager.h"
#import "DataSource.h"
#import "DataManager.h"
#import "Building.h"

@interface RGDBuildingViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property BOOL listOnlyBuildingsWithImages;
@property (nonatomic,strong) DataSource *dataSource;
@property (nonatomic,strong) MyDataManager *myDataManager;
@end

@implementation RGDBuildingViewController

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        _myDataManager = [[MyDataManager alloc] init];
        _dataSource = [[DataSource alloc] initForEntity:@"Building" sortKeys:@[@"name"] predicate:nil sectionNameKeyPath:@"firstLetterOfName" dataManagerDelegate:_myDataManager];
        
        _dataSource.delegate = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.tableView.dataSource = self.dataSource;
    self.dataSource.tableView = self.tableView;
    self.navigationItem.rightBarButtonItems = @[self.editButtonItem, self.navigationItem.rightBarButtonItem];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    NSNumber *boolNumber = [preferences objectForKey:kShowOnlyBuildingsWithImages];
    self.listOnlyBuildingsWithImages = [boolNumber boolValue];
    if (self.listOnlyBuildingsWithImages)
    {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"photo!=nil"];
        [self.dataSource updateWithPredicate:predicate];
    }
    else{
        [self.dataSource updateWithPredicate:nil];
    }
    [self.tableView reloadData];
}

#pragma mark - Data Source Cell Configurer

-(NSString*)cellIdentifierForObject:(id)object {
    return @"CellWithDisclosure";
}

-(void)configureCell:(UITableViewCell *)cell withObject:(id)object {
    Building *building = object;
    
    cell.textLabel.text = building.name;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

#pragma mark - editing
-(void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

#pragma mark - Segues
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"BuildingInfoSegue"]) {
        RGDBuildingInfoViewController *buildingInfoViewController = segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        __block Building *building = [self.dataSource objectAtIndexPath:indexPath];
        
        buildingInfoViewController.infoString = building.info;
        buildingInfoViewController.buildingImage = [[UIImage alloc] initWithData:building.photo];
        buildingInfoViewController.buildingName = building.name;
        buildingInfoViewController.completionBlock = ^(id obj){
            NSString *newInfo = obj;
            building.info = newInfo;
            [[DataManager sharedInstance] saveContext];
        };
    }
    else if ([segue.identifier isEqualToString:@"PreferencesSegue"]) {
        RGDPreferencesViewController *preferencesViewController = segue.destinationViewController;
        preferencesViewController.completionBlock = ^{[self dismissViewControllerAnimated:YES completion:NULL];};
    }
    else if ([segue.identifier isEqualToString:@"AddBuildingSegue"]) {
        RGDAddBuildingTableViewController *addBuildingTableViewController = segue.destinationViewController;
        addBuildingTableViewController.completionBlock = ^(id obj) {
            [self dismissViewControllerAnimated:YES completion:NULL];
            if (obj) {
                NSDictionary *dictionary = obj;
                [self.myDataManager addBuilding:dictionary];
            }
        };

    }
    
}

@end
