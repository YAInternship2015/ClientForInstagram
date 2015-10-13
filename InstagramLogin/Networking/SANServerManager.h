//
//  SANServerManager.h
//  InstagramLogin
//
//  Created by Admin on 04.10.15.
//  Copyright (c) 2015 Ignatenko_Alexandr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SANServerManager : NSObject

- (void)getTagsDictionary:(void(^)(NSDictionary *tags))tagsBlock
                onFailure:(void(^)(NSError* error, NSInteger statusCode))failure;
@end

