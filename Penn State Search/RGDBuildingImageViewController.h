//
//  RGDBuildingImageViewController.h
//  Penn State Search
//
//  Created by ROBERT GERALD DICK on 10/9/13.
//  Copyright (c) 2013 ROBERT GERALD DICK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RGDBuildingImageViewController : UIViewController

@property (strong, nonatomic) UIImage *image;
@property NSString *imageTitle;
@property (nonatomic,copy) CompletionBlock completionBlock;
@end
