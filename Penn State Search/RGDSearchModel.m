//
//  RGDSearchModel.m
//  Penn State Search
//
//  Created by ROBERT GERALD DICK on 10/1/13.
//  Copyright (c) 2013 ROBERT GERALD DICK. All rights reserved.
//

#import "RGDSearchModel.h"
#import "RHLDAPSearch.h"

@interface RGDSearchModel()
@property (strong, nonatomic) RHLDAPSearch *search;
@property (strong, nonatomic) NSArray *searchResults;

@end

@implementation RGDSearchModel

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

-(NSInteger)searchResultsCount
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

-(NSString*)titleForIndex:(NSInteger)index
{
    NSArray *titles = [self.searchResults[index] objectForKey:@"title"];
    NSString *title = titles[0];
    if (title.length == 0){
        title = @"No Title Available";
    }
    return title;
}

-(NSString*)numberForIndex:(NSInteger)index
{
    NSArray *numbers = [self.searchResults[index] objectForKey:@"telephoneNumber"];
    NSString *number = numbers[0];
    if (number.length == 0){
        number = @"+1 555 NIL DATA";
    }
    return number;
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
