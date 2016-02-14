//
//  MediaFullScreenViewController.m
//  Blocstagram
//
//  Created by Ellen Thuy Le on 2/14/16.
//  Copyright (c) 2016 Ellen Thuy Le. All rights reserved.
//

#import "MediaFullScreenViewController.h"
#import "Media.h"

@interface MediaFullScreenViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) Media *media;
@property (nonatomic, strong) UITapGestureRecognizer *tap;
@property (nonatomic, strong) UITapGestureRecognizer *doubleTap;

@end

@implementation MediaFullScreenViewController

- (instancetype) initWithMedia:(Media *)media {
    self = [super init];
    
    if (self) {
        self.media = media;
    }
    
    return self;
}

- (void) viewDidLoad {
    [super viewDidLoad];
    
    //#1 create and configure scroll view and make it the only subview of self.view
    self.scrollView = [UIScrollView new];
    self.scrollView.delegate = self;
    self.scrollView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.scrollView];
    
    //#2 create an image view, set the image, and add it as a subview of the scroll view
    self.imageView = [UIImageView new];
    self.imageView.image = self.media.image;
    
    [self.scrollView addSubview:self.imageView];
    
    //#3
    self.scrollView.contentSize = self.media.image.size;
    
    self.tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapFired:)];
    
    self.doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapFired:)];
    self.doubleTap.numberOfTapsRequired = 2;
    
    [self.tap requireGestureRecognizerToFail:self.doubleTap];
    
    [self.scrollView addGestureRecognizer:self.tap];
    [self.scrollView addGestureRecognizer:self.doubleTap];
}

- (void) viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    // #4 set the scroll view's frame to the view's bounds
    self.scrollView.frame = self.view.bounds;
    
    // #5
    CGSize scrollViewFrameSize = self.scrollView.frame.size;
    CGSize scrollViewContentSize = self.scrollView.contentSize;
    
    CGFloat scaleWidth = scrollViewFrameSize.width / scrollViewContentSize.width;
    CGFloat scaleHeight = scrollViewFrameSize.height / scrollViewContentSize.height;
    CGFloat minScale = MIN(scaleWidth, scaleHeight);
    
    self.scrollView.minimumZoomScale = minScale;
    self.scrollView.maximumZoomScale = 1;
}

//ensures that the image is centered
-(void) centerScrollView {
 
    [self.imageView sizeToFit];
    
    CGSize boundsSize = self.scrollView.bounds.size;
    CGRect contentsFrame = self.imageView.frame;
    
    if (contentsFrame.size.width < boundsSize.width) {
        contentsFrame.origin.x = (boundsSize.width - CGRectGetWidth(contentsFrame)) / 2;
    } else {
        contentsFrame.origin.x = 0;
    }
    
    if (contentsFrame.size.height < boundsSize.height) {
        contentsFrame.origin.y = (boundsSize.height - CGRectGetHeight(contentsFrame)) / 2;
    } else {
        contentsFrame.origin.y = 0;
    }
    
    self.imageView.frame = contentsFrame;
}

#pragma mark - UIScrollViewDelegate

// #6 tells the scroll view shich view to zoom in and out on
- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

// #7 calls centerScrollView after user has changed the zoom level
- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    [self centerScrollView];
}

//ensures that the image starts out centered
- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self centerScrollView];
}

#pragma mark - Gesture Recognizers
//when user single-taps, dismiss the view controller

- (void) tapFired:(UITapGestureRecognizer *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//when user double-taps, adjust the zoom level
- (void) doubleTapFired:(UITapGestureRecognizer *)sender {
    if (self.scrollView.zoomScale == self.scrollView.minimumZoomScale) {
        // #8 if you're zoomed out as far as possible, double tapping will zoom you in
        CGPoint locationPoint = [sender locationInView:self.imageView];
        
        CGSize scrollViewSize = self.scrollView.bounds.size;
        
        CGFloat width = scrollViewSize.width / self.scrollView.maximumZoomScale;
        CGFloat height = scrollViewSize.height / self.scrollView.maximumZoomScale;
        CGFloat x = locationPoint.x - (width / 2);
        CGFloat y = locationPoint.y - (height / 2);
        
        [self.scrollView zoomToRect:CGRectMake(x, y, width, height) animated:YES];
    } else {
        // #9 if you're zoomed in at all, then a double tap will zoom you out all the way
        [self.scrollView setZoomScale:self.scrollView.minimumZoomScale animated:YES];
    }
}


@end

