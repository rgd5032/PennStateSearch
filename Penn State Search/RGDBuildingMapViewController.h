//
//  RGDBuildingMapViewController.h
//  Penn State Search
//
//  Created by Robert Dick on 11/5/13.
//  Copyright (c) 2013 ROBERT GERALD DICK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface RGDBuildingMapViewController : UIViewController <MKMapViewDelegate>

@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) UIImage * photo;
@property CLLocationCoordinate2D mapCenter;
@end
