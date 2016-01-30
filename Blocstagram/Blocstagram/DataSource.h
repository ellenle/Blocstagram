//
//  DataSource.h
//  Blocstagram
//
//  Created by Ellen Thuy Le on 1/25/16.
//  Copyright (c) 2016 Ellen Thuy Le. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Media;

typedef void (^NewItemCompletionBlock)(NSError *error);

@interface DataSource : NSObject

+(instancetype) sharedInstance;
@property (nonatomic, strong, readonly) NSArray *mediaItems;

-(void)deleteMediaItem:(Media *)item;
-(void)addMediaItem:(Media *)item;

- (void) requestNewItemsWithCompletionHandler:(NewItemCompletionBlock)completionHandler;
- (void) requestOldItemsWithCompletionHandler:(NewItemCompletionBlock)completionHandler;

@end
