//
//  SANLoginViewController.m
//  ClientForInstagram
//
//  Created by Admin on 08.10.15.
//  Copyright (c) 2015 Ignatenko_Alexandr. All rights reserved.
//

#import "SANLoginViewController.h"
#import "AFNetworking.h"
#import "SANConstants.h"
#import "SANContainerViewController.h"

@interface SANLoginViewController ()

@property (nonatomic, weak) IBOutlet UIWebView *webView;

@end

@implementation SANLoginViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *fullAuthUrlString =
    [[NSString alloc] initWithFormat:@"%@?client_id=%@&redirect_uri=%@&response_type=code",
     kAuthUrlString, kClientID, kRedirectUri];
    
    NSURL *url = [NSURL URLWithString:fullAuthUrlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

- (void)dealloc {
    self.webView.delegate = nil;
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType {
    
    if ([[[request URL] host] isEqualToString:@"www.mydomain.com"]) {
        
        NSString *query = [[request URL] query];
        
        NSArray *array = [query componentsSeparatedByString:@"="];
        NSString *code = [array lastObject];
        
        NSDictionary *parameters = @{
                                     @"client_id"     : kClientID,
                                     @"client_secret" : kClientSecret,
                                     @"grant_type"    : @"authorization_code",
                                     @"redirect_uri"  : kRedirectUri,
                                     @"code" : code
                                     };
        __weak SANLoginViewController *weakLoginVC = self;
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager POST:@"https://api.instagram.com/oauth/access_token"
                parameters:parameters
                   success:^(AFHTTPRequestOperation *operation, id responseObject) {
                       NSLog(@"RESPONSE %@", responseObject);
                       NSString *token = responseObject[@"access_token"];
                       
                       NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
                       [userDefaults setObject:token forKey:@"token"];
                       [userDefaults synchronize];
                       
                       weakLoginVC.webView.delegate = nil;
                       SANContainerViewController *containerVC = [weakLoginVC.storyboard instantiateViewControllerWithIdentifier:@"SANContainerViewController"];
                       [weakLoginVC.navigationController pushViewController:containerVC animated:YES];
                       //[weakLoginVC dismissViewControllerAnimated:YES completion:nil];
                   } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
                       weakLoginVC.webView.delegate = nil;
                     //  [weakLoginVC dismissViewControllerAnimated:YES completion:nil];
                   }];
        //[self dismissViewControllerAnimated:YES completion:nil];
        return NO;
    }
    return YES;
}

@end
