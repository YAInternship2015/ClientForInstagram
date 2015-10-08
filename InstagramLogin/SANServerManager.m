//
//  SANServerManager.m
//  InstagramLogin
//
//  Created by Admin on 04.10.15.
//  Copyright (c) 2015 Ignatenko_Alexandr. All rights reserved.
//

#import "SANServerManager.h"
#import "SANTag.h"
#import "SANLoginViewController.h"
#import "SANAccessToken.h"
#import "AFNetworking.h"

@interface SANServerManager()

@property (nonatomic, strong) SANAccessToken *accessToken;

@end

@implementation SANServerManager

- (void)authorizeUser:(void(^)(SANTag *tag))completion {
    SANLoginViewController *loginViewController = [[SANLoginViewController alloc] initWithCompletionBlock:^(SANAccessToken *token) {
        self.accessToken = token;
        
        if (token) {
            [self getTagWithToken:self.accessToken
                        onSuccess:^(SANTag *tag) {
                            if (completion) {
                                completion(tag);
                            }
            }
                        onFailure:^(NSError *error, NSInteger statusCode) {
                            if (completion) {
                                completion(nil);
                            }
            }];
        }
    }];
    loginViewController.view.backgroundColor = [UIColor cyanColor];
    UIViewController *mainVC = [[[[UIApplication sharedApplication] windows] firstObject] rootViewController];
    
    [mainVC presentViewController:loginViewController animated:YES completion:nil];

}

- (void) getTagWithToken:(SANAccessToken *) token
    onSuccess:(void(^)(SANTag *tag)) success
    onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure {
    
        //https://api.instagram.com/v1/tags/{tag-name}?access_token=ACCESS-TOKEN
    
    NSDictionary* parameters = @{
                                 @"access_token" : [token getToken],
                                 @"count" : @100,
                                 @"min_tag_id" : @0
                                 };
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSLog(@"-----------------++++++++++++++++++++++++++--------------------");
    
    __weak SANServerManager *man = self;
    [manager GET:@"https://api.instagram.com/v1/tags/cat/media/recent"
      parameters:parameters
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSLog(@"JSON: %@", responseObject);
             
             NSArray *array = [responseObject objectForKey:@"data"];
             NSLog(@"COUNT ARRAY = %lu", (unsigned long)[array count]);
             
             
             man.tagArray = [NSMutableArray array];
             for (int i = 0; i < [array count]; i++) {
                 NSDictionary *dict = array[i];
                 NSDictionary *captionDictionary = [dict objectForKey:@"caption"];
                 NSString *text = [captionDictionary objectForKey:@"text"];
                 NSLog(@"\n\nTEXT %d,\n = %@", i, text);
                 
                 NSDictionary *imageDictionary = [dict objectForKey:@"images"];
                 NSDictionary *thumbnailDict = [imageDictionary objectForKey:@"thumbnail"];
                 NSString *imagePath = [thumbnailDict objectForKey:@"url"];
                 SANTag *tag = [[SANTag alloc] initWithText:text imagePath:imagePath];
                 [man.tagArray addObject:tag];
                 NSLog(@"manTag %@ text, %@ image\n\n\n", tag.text, tag.imagePath);
             }
            
             [self.delegate rel:self.tagArray];
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Error: %@", error);
         }];
    
    
    
    
    
    
    /*        [self.requestOperationManager
         GET:@"users.get"
         parameters:params
         success:^(AFHTTPRequestOperation *operation, NSDictionary* responseObject) {
             NSLog(@"JSON: %@", responseObject);
             
             NSArray* dictsArray = [responseObject objectForKey:@"response"];
             
             if ([dictsArray count] > 0) {
                 ASUser* user = [[ASUser alloc] initWithServerResponse:[dictsArray firstObject]];
                 if (success) {
                     success(user);
                 }
             } else {
                 if (failure) {
                     failure(nil, operation.response.statusCode);
                 }
             }
             
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"Error: %@", error);
             
             if (failure) {
                 failure(error, operation.response.statusCode);
             }
         }];
     */
}
        
@end
