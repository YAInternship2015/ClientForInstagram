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
        NSDictionary* parameters = @{
                                     @"access_token" : token,
                                     @"count" : kTagsCount
                                     };
        
        NSString *urlWithTag = [NSString stringWithFormat:@"https://api.instagram.com/v1/tags/%@/media/recent", kTags];
        
#warning в if и else явно дублируется код. Разница только в URL. В таком случае внутри if-else нужно понять, по какому урлу надо отправить запрос, и затем после if-else отправить запрос
        if (!url) {
            [self sendRequestWithUrl:urlWithTag parameters:parameters success:^(NSDictionary *tags) {
                success(tags);
            } failure:^(NSError *error, NSInteger statusCode) {
                failure(error, [error code]);
            }];
        } else {
            [self sendRequestWithUrl:url parameters:nil success:^(NSDictionary *tags) {
                success(tags);
            } failure:^(NSError *error, NSInteger statusCode) {
                failure(error, [error code]);
            }];
        }
    }
}

- (void)sendRequestWithUrl:(NSString *)url
                parameters:(NSDictionary *)parameters
                   success:(SANTagsDictionaryBlock)success
                   failure:(SANErrorBlock)failure {
    [self.manager GET:url
           parameters:parameters
              success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
                  success(responseObject);
              } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                  failure(error, [error code]);
              }];  
}

@end