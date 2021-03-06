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
    
    NSString *str = tag.imagePath;
    NSURL *url = [NSURL URLWithString:str];
    
    [self.avatarImageView setImageWithURL:url];
    self.nameLabel.text = tag.text;
}

@end
