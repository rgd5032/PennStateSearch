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
#import "kConstants.h"
#import "MyDataManager.h"
#import "DataSource.h"
#import "DataManager.h"
#import "Building.h"

@interface RGDBuildingViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property BOOL listOnlyBuildingsWithImages;
@property (nonatomic,strong) DataSource *dataSource;
@end

@implementation RGDBuildingViewController

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        MyDataManager *myDataManger = [[MyDataManager alloc] init];
        _dataSource = [[DataSource alloc] initForEntity:@"Building" sortKeys:@[@"name"] predicate:nil sectionNameKeyPath:@"firstLetterOfName" dataManagerDelegate:myDataManger];
        
        _dataSource.delegate = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.tableView.dataSource = self.dataSource;
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
//    Building *building = (Building *)object;
//    return building.photo == nil ? @"Cell" : @"CellWithDisclosure";
    return @"CellWithDisclosure";
}

-(void)configureCell:(UITableViewCell *)cell withObject:(id)object {
    Building *building = object;
    
    cell.textLabel.text = building.name;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

#pragma mark - Segues
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
//    if ([segue.identifier isEqualToString:@"BuildingImageSegue"]) {
//        RGDBuildingImageViewController *buildingImageViewController = segue.destinationViewController;
//        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//        Building *building = [self.dataSource objectAtIndexPath:indexPath];
//        buildingImageViewController.image = [[UIImage alloc] initWithData:building.photo];
//        buildingImageViewController.imageTitle = building.name;
//    }
    if ([segue.identifier isEqualToString:@"BuildingInfoSegue"]) {
        RGDBuildingInfoViewController *buildingInfoViewController = segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        __block Building *building = [self.dataSource objectAtIndexPath:indexPath];
        
        buildingInfoViewController.infoString = building.info;
        buildingInfoViewController.completionBlock = ^(id obj){
            NSString *newInfo = obj;
            building.info = newInfo;
            [[DataManager sharedInstance] saveContext];
        };
    }

    else if ([segue.identifier isEqualToString:@"PreferencesSegue"]) {
        RGDPreferencesViewController *preferencesViewController = segue.destinationViewController;
        preferencesViewController.CompletionBlock = ^{[self dismissViewControllerAnimated:YES completion:NULL];};
    }
}

@end
