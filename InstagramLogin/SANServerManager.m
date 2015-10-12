//
//  SANServerManager.m
//  InstagramLogin
//
//  Created by Admin on 04.10.15.
//  Copyright (c) 2015 Ignatenko_Alexandr. All rights reserved.
//

#import "SANServerManager.h"
#import "SANLoginViewController.h"
#import "AFNetworking.h"

@interface SANServerManager()

@property (nonatomic, strong) NSString *accessToken;
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

- (void)authorizeUser:(void(^)())success {
    NSString *fullAuthUrlString =
    [[NSString alloc] initWithFormat:@"%@?client_id=%@&redirect_uri=%@&response_type=code",
                                   kAuthUrlString, kClientID, kRedirectUri];
    
    SANLoginViewController *loginViewController =
    [[SANLoginViewController alloc] initWithAuthorizeUrlString:fullAuthUrlString
                                               completionBlock:^(NSString *token) {
        self.accessToken = token;
        success();
    }];
    
    UIViewController *mainVC = [[[[UIApplication sharedApplication] windows] firstObject] rootViewController];
    
    [mainVC presentViewController:loginViewController animated:YES completion:nil];
}

- (void)getTagsFromServer:(void(^)(NSDictionary *tagObjects))success {
    
    NSDictionary* parameters = @{
                                 @"access_token" : self.accessToken,
                                 @"count" : kTagsCount
                                 };
    
    NSString *urlWithTag = [NSString stringWithFormat:@"https://api.instagram.com/v1/tags/%@/media/recent", kTags];
    
    [self.manager GET:urlWithTag
      parameters:parameters
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
           //  NSLog(@"JSON: %@", responseObject);
             success(responseObject);
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Error: %@", error);
         }];
}

- (void)getTagsDictionary:(void(^)(NSDictionary *tags))tagsBlock
                onFailure:(void(^)(NSError* error, NSInteger statusCode))failure {
    
    if (!self.accessToken) {
        [self authorizeUser:^() {
            [self getTagsFromServer:^(NSDictionary *tagObjects) {
                tagsBlock(tagObjects);
            }];
        }];
    } else {
            [self getTagsFromServer:^(NSDictionary *tagObjects) {
                tagsBlock(tagObjects);
            }];
    }
}

@end
