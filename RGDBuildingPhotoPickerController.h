//
//  RGDBuildingPhotoPickerController.h
//  Penn State Search
//
//  Created by ROBERT GERALD DICK on 10/30/13.
//  Copyright (c) 2013 ROBERT GERALD DICK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RGDBuildingPhotoPickerController : UIImagePickerController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate>

@property (nonatomic, copy) CompletionBlock completionBlock;
@end
