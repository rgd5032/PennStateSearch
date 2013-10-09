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

-(BOOL)imageExistsForBuildingWithIndex:(NSInteger)index
{
    NSString *photoName = [self.buildings[index] objectForKey:@"photo"];
    if ([photoName isEqualToString:@""]){
        return NO;
    }
    else{
        return YES;
    }
}

@end
