//
//  RGDBuildingInfoViewController.h
//  Penn State Search
//
//  Created by ROBERT GERALD DICK on 10/29/13.
//  Copyright (c) 2013 ROBERT GERALD DICK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RGDBuildingInfoViewController : UIViewController

@property (nonatomic,strong) NSString *infoString;
@property (nonatomic,strong) UIImage *flagImage;

@property (nonatomic,copy) CompletionBlock completionBlock;

-(void)updateTextView;
@end
