//
//  SANLoginViewController.h
//  InstagramLogin
//
//  Created by Admin on 04.10.15.
//  Copyright (c) 2015 Ignatenko_Alexandr. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SANAccessToken;

typedef void(^SANLoginCompletionBlock)(SANAccessToken *token);

@interface SANLoginViewController : UIViewController

- (instancetype)initWithCompletionBlock:(SANLoginCompletionBlock)completionBlock;

@end
