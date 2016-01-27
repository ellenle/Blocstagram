//
//  MediaTableViewCell.h
//  Blocstagram
//
//  Created by Ellen Thuy Le on 1/26/16.
//  Copyright (c) 2016 Ellen Thuy Le. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Media;

@interface MediaTableViewCell : UITableViewCell

@property (nonatomic, strong) Media *mediaItem;

+ (CGFloat) heightForMediaItem:(Media *)mediaItem width:(CGFloat)width;

//Get the media item
- (Media *)mediaItem;

//Set a new media item
- (void)setMediaItem:(Media *)mediaItem;

@end
