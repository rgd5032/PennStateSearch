//
//  RGDBuildingModel.h
//  Penn State Search
//
//  Created by ROBERT GERALD DICK on 10/9/13.
//  Copyright (c) 2013 ROBERT GERALD DICK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RGDBuildingModel : NSObject
+(id)sharedInstance;
-(NSString*)buildingNameForIndex:(NSInteger)index;
-(UIImage*)imageForBuildingWithIndex:(NSInteger)index;
-(NSInteger)buildingCount;
-(NSInteger)buildingsWithImagesCount;
-(NSInteger)indexForNextBuildingWithImageStartingAtIndex:(NSInteger)index;
-(BOOL)imageExistsForBuildingWithIndex:(NSInteger)index;
@end
