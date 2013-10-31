//
//  RGDBuildingInfoViewController.h
//  Penn State Search
//
//  Created by ROBERT GERALD DICK on 10/29/13.
//  Copyright (c) 2013 ROBERT GERALD DICK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Building.h"

@interface RGDBuildingInfoViewController : UIViewController

@property (nonatomic,strong) NSString *infoString;
@property (nonatomic,strong) UIImage *buildingImage;
@property (nonatomic,strong) NSString *buildingName;
@property (nonatomic,strong) Building *building;

@property (nonatomic,copy) CompletionBlock completionBlock;

-(void)updateTextView;
@end
