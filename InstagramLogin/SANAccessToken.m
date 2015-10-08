//
//  SANAccessToken.m
//  InstagramLogin
//
//  Created by Admin on 04.10.15.
//  Copyright (c) 2015 Ignatenko_Alexandr. All rights reserved.
//

#import "SANAccessToken.h"

@interface SANAccessToken ()

@property (nonatomic, strong) NSString *token;

@end

@implementation SANAccessToken

- (instancetype)initWithToken:(NSString *)token {
    self = [super init];
    if (self) {
        self.token = token;
    }
    return self;
}

- (NSString *)getToken {
    return self.token;
}

@end
