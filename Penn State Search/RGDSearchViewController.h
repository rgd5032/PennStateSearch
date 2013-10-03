//
//  RGDSearchViewController.h
//  Penn State Search
//
//  Created by ROBERT GERALD DICK on 10/1/13.
//  Copyright (c) 2013 ROBERT GERALD DICK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RGDModel.h"

@protocol SearchDelegate <NSObject>

-(void)dismissMe;

@end


@interface RGDSearchViewController : UIViewController <UITableViewDataSource>
@property (strong, nonatomic) id<SearchDelegate> delegate;
@property (strong, nonatomic) RGDModel *model;
@end
