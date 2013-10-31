//
//  RGDBuildingPhotoPickerController.m
//  Penn State Search
//
//  Created by ROBERT GERALD DICK on 10/30/13.
//  Copyright (c) 2013 ROBERT GERALD DICK. All rights reserved.
//

#import "RGDBuildingPhotoPickerController.h"

@interface RGDBuildingPhotoPickerController ()

@property (nonatomic, strong) UIImage *imageChosen;
@end

@implementation RGDBuildingPhotoPickerController

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
    self.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    self.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Choose this photo?" delegate:nil cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Confirm" otherButtonTitles:nil];
    actionSheet.delegate = self;
    [actionSheet showInView:self.view];
    self.imageChosen = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    self.completionBlock(nil);
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:@"Confirm"]){
        self.completionBlock(self.imageChosen);
    }
}

@end
