//
//  Building.h
//  Penn State Search
//
//  Created by ROBERT GERALD DICK on 10/23/13.
//  Copyright (c) 2013 ROBERT GERALD DICK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Building : NSManagedObject

@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * opp_bldg_code;
@property (nonatomic, retain) NSData * photo;
@property (nonatomic, retain) NSNumber * year_constructed;

@end
