//
//  RGDBuildingImageViewController.m
//  Penn State Search
//
//  Created by ROBERT GERALD DICK on 10/9/13.
//  Copyright (c) 2013 ROBERT GERALD DICK. All rights reserved.
//

#import "RGDBuildingImageViewController.h"
#import "RGDBuildingModel.h"

@interface RGDBuildingImageViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UINavigationItem *navigationBar;
@property (strong, nonatomic) RGDBuildingModel *model;
@property (strong, nonatomic) UIImageView *imageView;
@end

@implementation RGDBuildingImageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    _model = [RGDBuildingModel sharedInstance];
    self.navigationBar.title = [self.model buildingNameForIndex:self.buildingIndex];
    
    UIImage *image = [self.model imageForBuildingWithIndex:self.buildingIndex];
    _imageView = [[UIImageView alloc] initWithImage:image];
    [self.scrollView   addSubview:self.imageView];
    
    self.scrollView.contentSize = image.size;
    
    self.scrollView.maximumZoomScale = 2.0;
    self.scrollView.minimumZoomScale = self.scrollView.bounds.size.width/image.size.width;
    self.scrollView.bounces = YES;
    self.scrollView.bouncesZoom = NO;
    
    self.scrollView.delegate = self;
    
    // I forgot to add this line in class.  Delegate must be set before doing this.
    [self.scrollView zoomToRect:self.imageView.bounds animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ScrollView Delegate
-(UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

@end
