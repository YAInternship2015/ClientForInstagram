//
//  SANCollectionViewCell.m
//  BestMovies
//
//  Created by Admin on 18.08.15.
//  Copyright (c) 2015 Ignatenko_Alexandr. All rights reserved.
//

#import "SANCollectionViewCell.h"
#import "SANTagObject.h"
#import "UIImageView+AFNetworking.h"

@interface SANCollectionViewCell()

@property (nonatomic, weak) IBOutlet UIImageView *imageView;

@end

@implementation SANCollectionViewCell

- (void)setupWithTag:(SANTagObject *)tag {
    
    NSString *str = [NSString stringWithFormat:@"%@", tag.imagePath];
    NSURL *url = [NSURL URLWithString:str];
    
    [self.imageView setImageWithURL:url];
}

@end

