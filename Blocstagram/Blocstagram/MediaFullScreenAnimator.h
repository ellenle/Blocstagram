//
//  MediaFullScreenAnimator.h
//  Blocstagram
//
//  Created by Ellen Thuy Le on 2/14/16.
//  Copyright (c) 2016 Ellen Thuy Le. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MediaFullScreenAnimator : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) BOOL presenting;
@property (nonatomic, weak) UIImageView *cellImageView;

@end


