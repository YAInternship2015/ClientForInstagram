//
//  SANLoginViewController.h
//  ClientForInstagram
//
//  Created by Admin on 08.10.15.
//  Copyright (c) 2015 Ignatenko_Alexandr. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *const kAuthUrlString  = @"https://api.instagram.com/oauth/authorize/";
static NSString *const kTokenUrlString = @"https://api.instagram.com/oauth/access_token/";
static NSString *const kClientID       = @"1b7349d77eb1421f9529a4728d201639";
static NSString *const kClientSecret   = @"d7663572df134539813ec5845fd146ea";
static NSString *const kRedirectUri    = @"http://mydomain.com/NeverGonnaFindMe/";

typedef void(^SANLoginCompletionBlock)(NSString *token);

@interface SANLoginViewController : UIViewController

- (instancetype)initWithAuthorizeUrlString:(NSString *)authUrlString
                           completionBlock:(SANLoginCompletionBlock)completionBlock;

@end
