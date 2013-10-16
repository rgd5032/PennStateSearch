//
//  BuildingInfo.h
//  Penn State Search
//
//  Created by ROBERT GERALD DICK on 10/16/13.
//  Copyright (c) 2013 ROBERT GERALD DICK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BuildingInfo : NSObject <NSCoding>
-(id)initWithName:(NSString*)name oppBuildingCode:(NSNumber*)oppBuildingCode yearConstructed:(NSNumber*)yearConstructed latitude:(NSNumber*)latitude logitude:(NSNumber*)longitude photoName:(NSString*)photoName;
@property (strong, nonatomic, readonly) NSString *name;
@property (strong, nonatomic, readonly) NSNumber *oppBuildingCode;
@property (strong, nonatomic, readonly) NSNumber *yearConstructed;
@property (strong, nonatomic, readonly) NSNumber *latitude;
@property (strong, nonatomic, readonly) NSNumber *longitude;
@property (strong, nonatomic, readonly) UIImage *photo;
@end
