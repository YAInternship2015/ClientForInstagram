//
//  SANServerManager.h
//  InstagramLogin
//
//  Created by Admin on 04.10.15.
//  Copyright (c) 2015 Ignatenko_Alexandr. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SANTagsDictionaryBlock)(NSDictionary *tags);
typedef void(^SANErrorBlock)(NSError* error, NSInteger statusCode);

@interface SANServerManager : NSObject

- (void)loadTagsFromServerWithPageUrl:(NSString *)url
                       TagsDictionary:(SANTagsDictionaryBlock)success
                            onFailure:(SANErrorBlock)failure;

@end

