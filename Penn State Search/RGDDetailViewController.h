//
//  RGDDetailViewController.h
//  Penn State Search
//
//  Created by ROBERT GERALD DICK on 10/8/13.
//  Copyright (c) 2013 ROBERT GERALD DICK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RGDModel.h"

@interface RGDDetailViewController : UIViewController
@property (strong, nonatomic) RGDModel *model;
@property NSInteger resultIndex;
@end
