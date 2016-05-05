//
//  subclassUICollectionViewCell.h
//  Blocstagram
//
//  Created by Ellen Thuy Le on 5/3/16.
//  Copyright © 2016 Ellen Thuy Le. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface subclassUICollectionViewCell : UICollectionViewCell

- (void)setupWithLayout:(UICollectionViewFlowLayout *)layout image:(UIImage *)image text:(NSString *)text;

@end
