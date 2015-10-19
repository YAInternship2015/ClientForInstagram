//
//  SANServerManager.m
//  InstagramLogin
//
//  Created by Admin on 04.10.15.
//  Copyright (c) 2015 Ignatenko_Alexandr. All rights reserved.
//

#import "SANServerManager.h"
#import "AFNetworking.h"
#import "SANDataSource.h"
#import "SANConstants.h"

@interface SANServerManager()

@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;

@end

@implementation SANServerManager

static NSString *const kTags  = @"michaeljackson";
static NSString *const kTagsCount  = @"30";

- (instancetype)init {
    self = [super init];
    if (self) {
        self.manager = [AFHTTPRequestOperationManager manager];
    }
    return self;
}

- (void)loadTagsFromServerWithPageUrl:(NSString *)url
                       TagsDictionary:(SANTagsDictionaryBlock)success
                            onFailure:(SANErrorBlock)failure {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [userDefaults objectForKey:@"token"];

    if (token) {
        NSString *urlWithTag = [NSString stringWithFormat:@"https://api.instagram.com/v1/tags/%@/media/recent", kTags];
        
        NSDictionary* parameters;
        NSString *sendUrl;
        
        if (url) {
            sendUrl = url;
        } else {
            sendUrl = urlWithTag;
            parameters = @{
                           @"access_token" : token,
                           @"count"        : kTagsCount
                           };
        }
        
        [self.manager GET:sendUrl
               parameters:parameters
                  success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
                      success(responseObject);
                  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                      failure(error, [error code]);
                  }];
    }
}

@end