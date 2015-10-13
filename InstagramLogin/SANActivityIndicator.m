//
//  SANActivityIndicator.m
//  InstagramLogin
//
//  Created by Admin on 13.10.15.
//  Copyright (c) 2015 Ignatenko_Alexandr. All rights reserved.
//

#import "SANActivityIndicator.h"
#import "AppDelegate.h"

@implementation SANActivityIndicator

- (void)showActivity {
    dispatch_async(dispatch_get_main_queue(), ^{
        if(![[UIApplication sharedApplication] isNetworkActivityIndicatorVisible])
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    });
}

- (void)hideActivity {
    dispatch_async(dispatch_get_main_queue(), ^{
        if([[UIApplication sharedApplication] isNetworkActivityIndicatorVisible])
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    });
}

@end
