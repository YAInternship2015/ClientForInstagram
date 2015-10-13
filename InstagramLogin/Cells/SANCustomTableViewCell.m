//
//  SANCustomTableViewCell.m
//  InstagramLogin
//
//  Created by Admin on 10.10.15.
//  Copyright (c) 2015 Ignatenko_Alexandr. All rights reserved.
//

#import "SANCustomTableViewCell.h"
#import "SANTagObject.h"
#import "UIImageView+AFNetworking.h"

@interface SANCustomTableViewCell()

@property (nonatomic, weak) IBOutlet UIImageView *avatarImageView;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;

@end

@implementation SANCustomTableViewCell

- (void)setupWithTag:(SANTagObject *)tag {
    
    NSString *str = [NSString stringWithFormat:@"%@", tag.imagePath];
    NSURL *url = [NSURL URLWithString:str];
    
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    
    __weak SANCustomTableViewCell *weakCell = self;
    self.avatarImageView.image = nil;
    [self.avatarImageView
     setImageWithURLRequest:request
     placeholderImage:nil
     success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
         weakCell.avatarImageView.image = image;
         [weakCell layoutSubviews];
     }
     failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
         
     }];
    self.nameLabel.text = tag.text;
}

@end
