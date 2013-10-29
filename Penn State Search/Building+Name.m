//
//  Building+Name.m
//  Penn State Search
//
//  Created by ROBERT GERALD DICK on 10/29/13.
//  Copyright (c) 2013 ROBERT GERALD DICK. All rights reserved.
//

#import "Building+Name.h"

@implementation Building (Name)

-(NSString*)firstLetterOfName
{
    NSString *letter = [self.name substringToIndex:1];
    
    NSRange range = [letter rangeOfCharacterFromSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]];
    if (range.location == NSNotFound) {
        letter = @"#";
    }
    
    return letter;
}
@end
