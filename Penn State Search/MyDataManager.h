//
//  MyDataManager.h
//  Penn State Search
//
//  Created by ROBERT GERALD DICK on 10/23/13.
//  Copyright (c) 2013 ROBERT GERALD DICK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataManagerDelegate.h"

@interface MyDataManager : NSObject <DataManagerDelegate>

-(void)addBuilding:(NSDictionary*)dictionary;
@end
