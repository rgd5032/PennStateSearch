//
//  RGDBuildingViewController.m
//  Penn State Search
//
//  Created by ROBERT GERALD DICK on 10/8/13.
//  Copyright (c) 2013 ROBERT GERALD DICK. All rights reserved.
//

#import "RGDBuildingViewController.h"
//#import "RGDBuildingModel.h"
#import "RGDBuildingImageViewController.h"
#import "RGDPreferencesViewController.h"
#import "kConstants.h"
#import "MyDataManager.h"
#import "DataSource.h"
#import "Building.h"

@interface RGDBuildingViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
//@property (strong, nonatomic) RGDBuildingModel *model;
@property BOOL listOnlyBuildingsWithImages;
@property (nonatomic,strong) DataSource *dataSource;
@end

@implementation RGDBuildingViewController

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        MyDataManager *myDataManger = [[MyDataManager alloc] init];
        _dataSource = [[DataSource alloc] initForEntity:@"Building" sortKeys:@[@"name"] predicate:nil sectionNameKeyPath:nil dataManagerDelegate:myDataManger];
        
        _dataSource.delegate = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.tableView.dataSource = self.dataSource;
    //_model = [RGDBuildingModel sharedInstance];
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
    Building *building = (Building *)object;
    return building.photo == nil ? @"Cell" : @"CellWithDisclosure";
}

-(void)configureCell:(UITableViewCell *)cell withObject:(id)object {
    Building *building = object;
    
    cell.textLabel.text = building.name;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

#pragma mark - Table View Data Source
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    // Return the number of sections.
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    // Return the number of rows in the section.
//    if (self.listOnlyBuildingsWithImages){
//        return [self.model buildingsWithImagesCount];
//    }
//    
//    return [self.model buildingCount];
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *CellIdentifier = @"Cell";
//    static NSString *DisclosureCellIdentifier = @"CellWithDisclosure";
//    UITableViewCell *cell;
//    NSInteger index = indexPath.row;
//    
//    if (self.listOnlyBuildingsWithImages){
//        index = [self.model indexForBuildingWithImageNumber:index];
//    }
//    
//    if(self.listOnlyBuildingsWithImages || [self.model imageExistsForBuildingWithIndex:index]){
//         cell = [tableView dequeueReusableCellWithIdentifier:DisclosureCellIdentifier forIndexPath:indexPath];
//    }
//    else{
//         cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
//    }
//    
//    // Configure the cell...
//    cell.textLabel.text = [self.model buildingNameForIndex:index];
//    
//    return cell;
//}

#pragma mark - Segues
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"BuildingImageSegue"]) {
        RGDBuildingImageViewController *buildingImageViewController = segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Building *building = [self.dataSource objectAtIndexPath:indexPath];
//        NSInteger index = indexPath.row;
//        if (self.listOnlyBuildingsWithImages){
//            index = [self.model indexForBuildingWithImageNumber:index];
//        }
//        buildingImageViewController.buildingIndex = index;
        buildingImageViewController.image = [[UIImage alloc] initWithData:building.photo];
        buildingImageViewController.imageTitle = building.name;
    }
    else if ([segue.identifier isEqualToString:@"PreferencesSegue"]) {
        RGDPreferencesViewController *preferencesViewController = segue.destinationViewController;
        preferencesViewController.CompletionBlock = ^{[self dismissViewControllerAnimated:YES completion:NULL];};
    }
}

@end
