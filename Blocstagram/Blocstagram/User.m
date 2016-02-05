
//
//  User.m
//  Blocstagram
//
//  Created by Ellen Thuy Le on 1/25/16.
//  Copyright (c) 2016 Ellen Thuy Le. All rights reserved.
//

#import "User.h"

@implementation User

- (instancetype) initWithDictionary:(NSDictionary *)userDictionary {
    self = [super init];
    
    if (self) {
        self.idNumber = userDictionary[@"id"];
        self.userName = userDictionary[@"username"];
        self.fullName = userDictionary[@"full_name"];
        
        NSString *profileURLString = userDictionary[@"profile_picture"];
        NSURL *profileURL = [NSURL URLWithString:profileURLString];
        
        if (profileURL) {
            self.profilePictureURL = profileURL;
        }
    }
    
    return self;
}

@end
