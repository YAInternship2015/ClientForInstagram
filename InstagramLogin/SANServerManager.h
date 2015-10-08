//
//  SANServerManager.h
//  InstagramLogin
//
//  Created by Admin on 04.10.15.
//  Copyright (c) 2015 Ignatenko_Alexandr. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SANTag;

@protocol XXX;

@interface SANServerManager : NSObject

@property (nonatomic, strong) NSMutableArray *tagArray;
@property (nonatomic, weak) id<XXX> delegate;

- (void)authorizeUser:(void(^)(SANTag *user))completion;

@end

@protocol XXX

- (void) rel:(NSArray *)array;

@end