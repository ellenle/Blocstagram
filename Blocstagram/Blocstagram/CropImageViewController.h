//
//  CropImageViewController.h
//  Blocstagram
//
//  Created by Ellen Thuy Le on 4/12/16.
//  Copyright (c) 2016 Ellen Thuy Le. All rights reserved.
//

#import "MediaFullScreenViewController.h"

@class CropImageViewController;

@protocol CropImageViewContollerDelegate <NSObject>

- (void) cropControllerFinishedWithImage:(UIImage *)croppedImage;

@end

@interface CropImageViewController : MediaFullScreenViewController

- (instancetype) initWithImage:(UIImage *)sourceImage;

@property (nonatomic, weak) NSObject <CropImageViewContollerDelegate> *delegate;

@end
