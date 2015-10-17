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

- (instancetype)initWithUrl:(NSString *)url {
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
        
        if (!url) {
            [self.manager GET:urlWithTag
                   parameters:parameters
                      success:^(AFHTTPRequestOperation *operation, id responseObject) {
                          success(responseObject);
                      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                          failure(error, [error code]);
                      }];
        } else {
            [self.manager GET:url
                   parameters:nil
                      success:^(AFHTTPRequestOperation *operation, id responseObject) {
                          success(responseObject);
                      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                          failure(error, [error code]);
                      }];
        }
    }
}

@end