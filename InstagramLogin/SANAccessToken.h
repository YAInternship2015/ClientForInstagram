//
//  SANAccessToken.h
//  InstagramLogin
//
//  Created by Admin on 04.10.15.
//  Copyright (c) 2015 Ignatenko_Alexandr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SANAccessToken : NSObject

- (instancetype)initWithToken:(NSString *)token;
- (NSString *)getToken;

@end
