//
//  RGDModel.m
//  Penn State Search
//
//  Created by ROBERT GERALD DICK on 10/1/13.
//  Copyright (c) 2013 ROBERT GERALD DICK. All rights reserved.
//

#import "RGDModel.h"
#import "RHLDAPSearch.h"

@interface RGDModel()
@property (strong, nonatomic) RHLDAPSearch *search;

@end

@implementation RGDModel

-(id)init
{
    self = [super init];
    if (self){
        _search = [[RHLDAPSearch alloc] initWithURL:@"ldap://ldap.psu.edu:389"];
    }
    
    return self;
}

-(void)searchWithFirstName:(NSString *)firstName lastName:(NSString *)lastName accessID:(NSString *)aId
{
    NSString *queryString = @"(&";
    if (![firstName isEqualToString:@""]){
        queryString = [queryString stringByAppendingFormat: @"(givenName=%@*)", firstName];
    }
    if (![lastName isEqualToString:@""]){
        queryString = [queryString stringByAppendingFormat: @"(sn=%@)", lastName];
    }
    if (![aId isEqualToString:@""]){
        queryString = [queryString stringByAppendingFormat: @"(uid=%@)", aId];
    }
    queryString = [queryString stringByAppendingString: @")"];
    
    NSError *error = [[NSError alloc] init];
    NSArray *results = [[NSArray alloc] init];
    
    results = [self.search searchWithQuery:queryString withinBase:@"dc=psu, dc=edu" usingScope:RH_LDAP_SCOPE_SUBTREE error:&error];
}

@end
