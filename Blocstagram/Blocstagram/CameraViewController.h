//
//  CameraViewController.h
//  Blocstagram
//
//  Created by Ellen Thuy Le on 4/5/16.
//  Copyright (c) 2016 Ellen Thuy Le. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CameraViewController;

@protocol CameraViewControllerDelegate <NSObject>

- (void) cameraViewController:(CameraViewController *)cameraViewController didCompleteWithImage:(UIImage *)image;

@end

@interface CameraViewController : UIViewController

@property (nonatomic, weak) NSObject <CameraViewControllerDelegate> *delegate;

@end
