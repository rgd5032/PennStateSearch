//
//  RGDBuildingMapViewController.m
//  Penn State Search
//
//  Created by Robert Dick on 11/5/13.
//  Copyright (c) 2013 ROBERT GERALD DICK. All rights reserved.
//

#import "RGDBuildingMapViewController.h"
#import "RGDBuildingImageViewController.h"

@interface RGDBuildingMapViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation RGDBuildingMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidLoad
{
    [super viewDidLoad];

    //[self geocodeInfo];
    [self updateMapView];
}

- (void) updateMapView
{
    // ---- Region ----
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(self.mapCenter, 500, 500);
    [self.mapView setRegion:region];
    
    // ---- Annotations ----
    
    [self.mapView removeAnnotations:[self.mapView annotations]];
    
    MKPointAnnotation * building = [[MKPointAnnotation alloc] init];
    [building setCoordinate:self.mapCenter];
    [building setTitle:self.name];
    [self.mapView addAnnotation:building];
}

//- (void) geocodeInfo {
//    CLGeocoder * geocoder1 = [[CLGeocoder alloc] init];
//    CLGeocoder * geocoder2 = [[CLGeocoder alloc] init];
//    
//    NSMutableDictionary * stateAddressDict = [[NSMutableDictionary alloc] init];
//    [stateAddressDict setValue:self.title
//                        forKey:[NSString stringWithFormat:@"%@", kABPersonAddressStateKey]];
//    
//    [geocoder1 geocodeAddressDictionary:stateAddressDict
//                      completionHandler:^(NSArray * placemarks, NSError * error) {
//                          if (placemarks) {
//                              CLPlacemark * place = (CLPlacemark *)[placemarks objectAtIndex:0];
//                              [self setMapCenter:place.location.coordinate];
//                              [self updateMapView];
//                              
//                          }
//                      }];
//    
//    NSMutableDictionary * capAddressDict = [[NSMutableDictionary alloc] init];
//    [capAddressDict setValue:self.title
//                      forKey:[NSString stringWithFormat:@"%@", kABPersonAddressStateKey]];
//    [capAddressDict setValue:self.capitalName
//                      forKey:[NSString stringWithFormat:@"%@", kABPersonAddressCityKey]];
//    
//    [geocoder2 geocodeAddressDictionary:capAddressDict
//                      completionHandler:^(NSArray * placemarks, NSError * error) {
//                          if (placemarks) {
//                              CLPlacemark * place = (CLPlacemark *)[placemarks objectAtIndex:0];
//                              [self setCapCenter:place.location.coordinate];
//                              [self updateMapView];
//                          }
//                      }];
//}

#pragma mark - MapView Delegate

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MKAnnotationView * annoView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"annoView"];
    
    if (!annoView) {
        annoView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"annoView"];
        
    } else {
        [annoView setAnnotation:annotation];
    }
    
    if (self.photo != nil)
    {
        UIButton *detail = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        [annoView setRightCalloutAccessoryView:detail];
    }
    
    annoView.image = [UIImage imageNamed:@"177-building.png"];
    annoView.canShowCallout = YES;
    
    return annoView;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    RGDBuildingImageViewController *buildingImageViewController = [[RGDBuildingImageViewController alloc]init];
    buildingImageViewController.image = self.photo;
    buildingImageViewController.imageTitle = self.name;
    buildingImageViewController.completionBlock = ^(id obj){
        [self dismissViewControllerAnimated:true completion:NULL];
    };

    //[self presentViewController:buildingImageViewController animated:YES completion:NULL];
    [self.navigationController pushViewController:buildingImageViewController animated:YES];
}

@end
