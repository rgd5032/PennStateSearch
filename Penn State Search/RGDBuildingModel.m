//
//  RGDBuildingModel.m
//  Penn State Search
//
//  Created by ROBERT GERALD DICK on 10/9/13.
//  Copyright (c) 2013 ROBERT GERALD DICK. All rights reserved.
//

#import "RGDBuildingModel.h"
#import "BuildingInfo.h"
static NSString * const filename = @"buildings.archive";

@interface RGDBuildingModel()

@property (strong, nonatomic) NSMutableArray *buildings;

@end

@implementation RGDBuildingModel

+(id)sharedInstance
{
    static id singleton = nil;
    if (!singleton){
        singleton = [[self alloc] init];
    }
    return singleton;
}

-(id)init
{
    self = [super init];
    if (self){
        if ([self fileExists]){
            NSString *path = [self filePath];
            _buildings = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        }
        else {
            NSBundle *mainBundle = [NSBundle mainBundle];
            NSString *buildingsPath = [mainBundle pathForResource:@"buildings" ofType:@"plist"];
            NSArray *buildings = [[NSArray alloc] initWithContentsOfFile:buildingsPath];
            
            _buildings = [NSMutableArray array];
            for (NSDictionary *dict in buildings) {
                BuildingInfo *building = [[BuildingInfo alloc] initWithName:dict[@"name"] oppBuildingCode:dict[@"opp_bldg_code"] yearConstructed:dict[@"year_constructed"] latitude:dict[@"latitude"] logitude:dict[@"longitude"] photoName:dict[@"photo"]];
                [_buildings addObject:building];
            }
            
            [_buildings sortUsingComparator: ^(BuildingInfo *bldg1, BuildingInfo *bldg2){
                if ([bldg1.name compare:bldg2.name] > 0) {
                    return (NSComparisonResult)NSOrderedDescending;
                }
                 
                if ([bldg1.name compare:bldg2.name] < 0) {
                    return (NSComparisonResult)NSOrderedAscending;
                }
                return (NSComparisonResult)NSOrderedSame;
            }];
            
            [NSKeyedArchiver archiveRootObject:_buildings toFile:[self filePath]];
       }
    }
    
    return self;
}


#pragma mark - File System
-(NSString*)applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

-(NSString *)filePath {
    return [[self applicationDocumentsDirectory] stringByAppendingPathComponent:filename];
}

-(BOOL)fileExists {
    NSString *path = [self filePath];
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
}


#pragma mark - Public methods
-(NSString*)buildingNameForIndex:(NSInteger)index
{
    BuildingInfo *bldg = self.buildings[index];
    return bldg.name;
}

-(UIImage*)imageForBuildingWithIndex:(NSInteger)index
{
    BuildingInfo *bldg = self.buildings[index];
    return bldg.photo;
}

-(NSInteger)buildingCount
{
    return self.buildings.count;
}

-(NSInteger)buildingsWithImagesCount
{
    NSInteger count = 0;
    for (BuildingInfo *bldg in self.buildings) {
        if (bldg.photo != nil){
            count++;
        }
    }
    
    return count;
}

-(BOOL)imageExistsForBuildingWithIndex:(NSInteger)index
{
    BuildingInfo *bldg = self.buildings[index];
    if (bldg.photo == nil){
        return NO;
    }
    else{
        return YES;
    }
}

-(NSInteger)indexForBuildingWithImageNumber:(NSInteger)number
{
    NSInteger imagesFound = 0;
    
    for (int i = 0; i < self.buildings.count; i++){
        if ([self imageExistsForBuildingWithIndex:i]){
            imagesFound++;
        }
        if (imagesFound == (number+1)){
            return i;
        }
    }
    return -1;
}

@end
