//
//  BuildingInfo.m
//  Penn State Search
//
//  Created by ROBERT GERALD DICK on 10/16/13.
//  Copyright (c) 2013 ROBERT GERALD DICK. All rights reserved.
//

#import "BuildingInfo.h"
@interface BuildingInfo()
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSNumber *oppBuildingCode;
@property (strong, nonatomic) NSNumber *yearConstructed;
@property (strong, nonatomic) NSNumber *latitude;
@property (strong, nonatomic) NSNumber *longitude;
@property (strong, nonatomic) UIImage *photo;

@end

@implementation BuildingInfo
-(id)initWithName:(NSString*)name oppBuildingCode:(NSNumber*)oppBuildingCode yearConstructed:(NSNumber*)yearConstructed latitude:(NSNumber*)latitude logitude:(NSNumber*)longitude photoName:(NSString*)photoName
{
    self = [super init];
    if (self) {
        _name = name;
        _oppBuildingCode = oppBuildingCode;
        _yearConstructed = yearConstructed;
        _latitude = latitude;
        _longitude = longitude;
        photoName = [NSString stringWithFormat:@"%@.jpg",photoName];
        _photo = [UIImage imageNamed:photoName];
    }
    return self;

}

#pragma mark - NSCoding Protol
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        _name = [aDecoder decodeObjectForKey:@"name"];
        _oppBuildingCode = [aDecoder decodeObjectForKey:@"buildingCode"];
        _yearConstructed = [aDecoder decodeObjectForKey:@"yearConstructed"];
        _latitude = [aDecoder decodeObjectForKey:@"latitude"];
        _longitude = [aDecoder decodeObjectForKey:@"longitude"];
        _photo = [aDecoder decodeObjectForKey:@"photo"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeObject:_oppBuildingCode forKey:@"buildingCode"];
    [aCoder encodeObject:_yearConstructed forKey:@"yearConstructed"];
    [aCoder encodeObject:_latitude forKey:@"latitude"];
    [aCoder encodeObject:_longitude forKey:@"longitude"];
    [aCoder encodeObject:_photo forKey:@"photo"];
}

@end
