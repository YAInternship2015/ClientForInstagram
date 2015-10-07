//
//  SANServerManager.m
//  InstagramLogin
//
//  Created by Admin on 04.10.15.
//  Copyright (c) 2015 Ignatenko_Alexandr. All rights reserved.
//

#import "SANServerManager.h"
#import "SANUser.h"
#import "SANLoginViewController.h"
#import "SANAccessToken.h"

@interface SANServerManager()

@property (nonatomic, strong) SANAccessToken *accessToken;

@end

@implementation SANServerManager

- (void)authorizeUser:(void(^)(SANUser *user))completion {
    SANLoginViewController *loginViewController = [[SANLoginViewController alloc] initWithCompletionBlock:^(SANAccessToken *token) {
        self.accessToken = token;
        if (completion) {
            completion(nil);
        }
    }];
    loginViewController.view.backgroundColor = [UIColor cyanColor];
    //loginViewController.view.frame = CGRectMake(20, 20, 400, 400);
    UIViewController *mainVC = [[[[UIApplication sharedApplication] windows] firstObject] rootViewController];
    
   // UINavigationController *navVC = [[UINavigationController alloc]initWithRootViewController:loginViewController];;
    
    [mainVC presentViewController:loginViewController animated:YES completion:^{
        NSLog(@"present");
    }];
}

@end
