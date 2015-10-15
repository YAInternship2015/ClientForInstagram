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
    
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    
    __weak SANCollectionViewCell *weakCell = self;
    self.imageView.image = nil;
#warning можно было испольщовать - (void)setImageWithURL:(NSURL *)url, то же самое в collectionViewCell
    [self.imageView
     setImageWithURLRequest:request
     placeholderImage:nil
     success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
         weakCell.imageView.image = image;
     }
     failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
         
     }];
}

@end

