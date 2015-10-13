//
//  SANCustomTableViewCell.h
//  InstagramLogin
//
//  Created by Admin on 10.10.15.
//  Copyright (c) 2015 Ignatenko_Alexandr. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SANTagObject;

@interface SANCustomTableViewCell : UITableViewCell

- (void)setupWithTag:(SANTagObject *)tag;

@end
