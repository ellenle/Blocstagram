//
//  subclassUICollectionViewCell.m
//  Blocstagram
//
//  Created by Ellen Thuy Le on 5/3/16.
//  Copyright © 2016 Ellen Thuy Le. All rights reserved.
//

#import "subclassUICollectionViewCell.h"

@implementation subclassUICollectionViewCell

-(instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
@end
