//
//  MyDataManager.m
//  Penn State Search
//
//  Created by ROBERT GERALD DICK on 10/23/13.
//  Copyright (c) 2013 ROBERT GERALD DICK. All rights reserved.
//

#import "MyDataManager.h"
#import "DataManager.h"
#import "Building.h"

@implementation MyDataManager

-(NSString*)xcDataModelName {
    return @"Buildings";
}

-(void)createDatabaseFor:(DataManager *)dataManager {
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *plistPath = [bundle pathForResource:@"buildings" ofType:@"plist"];
    NSArray *buildingArray = [NSArray arrayWithContentsOfFile:plistPath];
    
    NSManagedObjectContext *managedObjectContext = dataManager.managedObjectContext;
    
    for (NSDictionary *dictionary in buildingArray) {
        Building *building = [NSEntityDescription insertNewObjectForEntityForName:@"Building" inManagedObjectContext:managedObjectContext];
        
        building.name = [dictionary objectForKey:@"name"];
        building.opp_bldg_code = [dictionary objectForKey:@"opp_bldg_code"];
        building.year_constructed = [dictionary objectForKey:@"year_constructed"];
        building.latitude = [dictionary objectForKey:@"latitude"];
        building.longitude = [dictionary objectForKey:@"longitude"];
        NSString *imageName = [dictionary objectForKey:@"photo"];
        imageName = [imageName stringByAppendingString:@".jpg"];
        UIImage *image = [UIImage imageNamed:imageName];
        building.photo = UIImagePNGRepresentation(image);
    }
    
    [dataManager saveContext];
}


@end
