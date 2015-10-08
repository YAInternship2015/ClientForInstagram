//
//  SANTagName.m
//  InstagramLogin
//
//  Created by Admin on 07.10.15.
//  Copyright (c) 2015 Ignatenko_Alexandr. All rights reserved.
//

#import "SANTag.h"

@interface SANTag ()



@end

@implementation SANTag

-(instancetype)initWithText:(NSString *)text imagePath:(NSString *)imagePath {
    self = [super init];
    if (self) {
        self.text = text;
        self.imagePath = imagePath;
    }
    return self;
}

@end
