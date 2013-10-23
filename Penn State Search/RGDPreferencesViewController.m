//
//  RGDPreferencesViewController.m
//  Penn State Search
//
//  Created by ROBERT GERALD DICK on 10/15/13.
//  Copyright (c) 2013 ROBERT GERALD DICK. All rights reserved.
//

#import "RGDPreferencesViewController.h"
#import "kConstants.h"

@interface RGDPreferencesViewController ()
@property (weak, nonatomic) IBOutlet UISwitch *zoomSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *buildingListSwitch;
- (IBAction)dismiss:(id)sender;


@end

@implementation RGDPreferencesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    NSNumber *boolNumber = [preferences objectForKey:kZoomImages];
    self.zoomSwitch.on = [boolNumber boolValue];
    boolNumber = [preferences objectForKey:kShowOnlyBuildingsWithImages];
    self.buildingListSwitch.on = [boolNumber boolValue];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dismiss:(id)sender {
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    [preferences setBool:self.zoomSwitch.isOn forKey:kZoomImages];
    [preferences setBool:self.buildingListSwitch.isOn forKey:kShowOnlyBuildingsWithImages];
    [preferences synchronize];
    
    self.CompletionBlock();
}
@end
