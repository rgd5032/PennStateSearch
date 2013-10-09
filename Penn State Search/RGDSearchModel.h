//
//  RGDSearchModel.h
//  Penn State Search
//
//  Created by ROBERT GERALD DICK on 10/1/13.
//  Copyright (c) 2013 ROBERT GERALD DICK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RGDSearchModel : NSObject
+(id)sharedInstance;
-(void)searchWithFirstName:(NSString *)firstName lastName:(NSString *)lastName accessID:(NSString *)aId;
- (BOOL)resultsFound;
-(NSInteger)searchResultsCount;
-(NSString*)displayNameForIndex:(NSInteger)index;
-(NSString*)addressForIndex:(NSInteger)index;
-(NSString*)emailForIndex:(NSInteger)index;
-(NSString*)titleForIndex:(NSInteger)index;
@end
