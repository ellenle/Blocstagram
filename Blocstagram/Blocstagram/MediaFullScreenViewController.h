//
//  MediaFullScreenViewController.h
//  Blocstagram
//
//  Created by Ellen Thuy Le on 2/14/16.
//  Copyright (c) 2016 Ellen Thuy Le. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Media;

@interface MediaFullScreenViewController : UIViewController

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) Media *media;

- (instancetype) initWithMedia:(Media *)media;

- (void) centerScrollView;

- (void) recalculateZoomScale;

@end

