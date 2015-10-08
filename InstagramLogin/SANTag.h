//
//  SANTagName.h
//  InstagramLogin
//
//  Created by Admin on 07.10.15.
//  Copyright (c) 2015 Ignatenko_Alexandr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SANTag : NSObject

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *imagePath;

-(instancetype)initWithText:(NSString *)text imagePath:(NSString *)imagePath;

@end
