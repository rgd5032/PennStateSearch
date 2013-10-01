//
//  RGDSearchViewController.h
//  Penn State Search
//
//  Created by ROBERT GERALD DICK on 10/1/13.
//  Copyright (c) 2013 ROBERT GERALD DICK. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SearchDelegate <NSObject>

-(void)dismissMe;

@end


@interface RGDSearchViewController : UIViewController
@property (nonatomic,strong) id<SearchDelegate> delegate;
@end
