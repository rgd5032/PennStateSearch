//
//  RGDBuildingImageViewController.m
//  Penn State Search
//
//  Created by ROBERT GERALD DICK on 10/9/13.
//  Copyright (c) 2013 ROBERT GERALD DICK. All rights reserved.
//

#import "RGDBuildingImageViewController.h"
#import "kConstants.h"

@interface RGDBuildingImageViewController () <UIScrollViewDelegate>
- (IBAction)dismissPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UINavigationItem *titleBarItem;
@property (strong, nonatomic) UIImageView *imageView;
@property BOOL zoomImages;
@end

@implementation RGDBuildingImageViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view
    
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    NSNumber *boolNumber = [preferences objectForKey:kZoomImages];
    self.zoomImages = [boolNumber boolValue];
    
    self.titleBarItem.title = self.imageTitle;
    _imageView = [[UIImageView alloc] initWithImage:self.image];
    [self.scrollView   addSubview:self.imageView];
    
    self.scrollView.contentSize = self.image.size;
    
    if (self.zoomImages){
        self.scrollView.maximumZoomScale = 2.0;
    }
    else {
        self.scrollView.maximumZoomScale = self.scrollView.bounds.size.width/self.image.size.width;
    }
    self.scrollView.minimumZoomScale = self.scrollView.bounds.size.width/self.image.size.width;
    self.scrollView.bounces = YES;
    self.scrollView.bouncesZoom = NO;
    
    self.scrollView.delegate = self;
    
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

#pragma mark - IBActions
- (IBAction)dismissPressed:(id)sender {
    self.completionBlock(nil);
}
@end
