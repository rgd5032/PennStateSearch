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
@property (strong, nonatomic) NSArray *searchResults;

@end

@implementation RGDModel

-(id)init
{
    self = [super init];
    if (self){
        _search = [[RHLDAPSearch alloc] initWithURL:@"ldap://ldap.psu.edu:389"];
        self.searchResults = [[NSArray alloc] init];
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
    
    self.searchResults = [self.search searchWithQuery:queryString withinBase:@"dc=psu, dc=edu" usingScope:RH_LDAP_SCOPE_SUBTREE error:&error];
}

-(NSInteger)count
{
    return self.searchResults.count;
}

-(NSString*)displayNameForIndex:(NSInteger)index
{
    NSArray *names = [self.searchResults[index] objectForKey:@"displayName"];
    NSString *name = names[0];
    return name;
}

-(NSString*)addressForIndex:(NSInteger)index
{
    NSArray *addresses = [self.searchResults[index] objectForKey:@"postalAddress"];
    NSString *address = addresses[0];
    
    if (address.length == 0){
        address = @"No Address Available";
    }
    else{
        address = [address stringByReplacingOccurrencesOfString:@"$" withString:@"\n"];
    }
    
    return address;
}

-(NSString*)emailForIndex:(NSInteger)index
{
    NSArray *emails = [self.searchResults[index] objectForKey:@"mail"];
    NSString *email = emails[0];
    return email;
}

-(NSString*)affiliationForIndex:(NSInteger)index
{
    NSArray *affiliations = [self.searchResults[index] objectForKey:@"eduPersonPrimaryAffiliation"];
    NSString *affiliation = affiliations[0];
    return affiliation;
}

- (BOOL)resultsFound
{
    if (self.searchResults.count == 0){
        return NO;
    }
    else{
        return YES;
    }
}

@end
