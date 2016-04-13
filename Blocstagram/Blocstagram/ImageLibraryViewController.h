//
//  ImageLibraryViewController.h
//  Blocstagram
//
//  Created by Ellen Thuy Le on 4/12/16.
//  Copyright (c) 2016 Ellen Thuy Le. All rights reserved.
//

#import <UIKit/UIKit.h>


@class ImageLibraryViewController;

@protocol ImageLibraryViewControllerDelegate <NSObject>

- (void) imageLibraryViewController:(ImageLibraryViewController *)imageLibraryViewController didCompleteWithImage:(UIImage *)image;

@end

@interface ImageLibraryViewController : UICollectionViewController

@property (nonatomic, weak) NSObject <ImageLibraryViewControllerDelegate> *delegate;

@end
