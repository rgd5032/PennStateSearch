//
//  RGDBuildingModel.m
//  Penn State Search
//
//  Created by ROBERT GERALD DICK on 10/9/13.
//  Copyright (c) 2013 ROBERT GERALD DICK. All rights reserved.
//

#import "RGDBuildingModel.h"

@interface RGDBuildingModel()

@property (strong, nonatomic) NSArray *buildings;

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
        NSBundle *mainBundle = [NSBundle mainBundle];
        NSString *buildingsPath = [mainBundle pathForResource:@"buildings" ofType:@"plist"];
        _buildings = [[NSArray alloc] initWithContentsOfFile:buildingsPath];
        NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
        NSArray *descriptors = [[NSArray alloc] initWithObjects:descriptor, nil];
        self.buildings = [self.buildings sortedArrayUsingDescriptors:descriptors];
    }
    
    return self;
}

-(NSString*)buildingNameForIndex:(NSInteger)index
{
    NSString *name = [self.buildings[index] objectForKey:@"name"];
    return name;
}

-(UIImage*)imageForBuildingWithIndex:(NSInteger)index
{
    NSString *imageName = [self.buildings[index] objectForKey:@"photo"];
    imageName = [imageName stringByAppendingString:@".jpg"];
    UIImage *image = [UIImage imageNamed:imageName];
    return image;
}

-(NSInteger)buildingCount
{
    return self.buildings.count;
}

-(NSInteger)buildingsWithImagesCount
{
    NSInteger count = 0;
    for (NSDictionary *building in self.buildings) {
        NSString *photoName = [building objectForKey:@"photo"];
        if (photoName.length != 0){
            count++;
        }
    }
    
    return count;
}

-(BOOL)imageExistsForBuildingWithIndex:(NSInteger)index
{
    NSString *photoName = [self.buildings[index] objectForKey:@"photo"];
    if (photoName.length == 0){
        return NO;
    }
    else{
        return YES;
    }
}

// THIS DOESN'T WORK -> for i = 1..7 it will return index 7.  Want it to return 1st with image, then 2nd with image.
-(NSInteger)indexForNextBuildingWithImageStartingAtIndex:(NSInteger)index
{
    for (int i = index; i < self.buildings.count; i++){
        if ([self imageExistsForBuildingWithIndex:i]){
            return i;
        }
    }
    return -1;
}

@end
