//
//  SANCollectionViewCell.h
//  BestMovies
//
//  Created by Admin on 18.08.15.
//  Copyright (c) 2015 Ignatenko_Alexandr. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SANTagObject;

@interface SANCollectionViewCell : UICollectionViewCell

- (void)setupWithTag:(SANTagObject *)tag;

@end
