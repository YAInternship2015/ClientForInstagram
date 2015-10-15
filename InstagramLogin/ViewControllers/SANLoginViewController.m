//
//  SANLoginViewController.m
//  ClientForInstagram
//
//  Created by Admin on 08.10.15.
//  Copyright (c) 2015 Ignatenko_Alexandr. All rights reserved.
//

#import "SANLoginViewController.h"
#import "AFNetworking.h"

@interface SANLoginViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) NSString *fullAuthUrlString;
@property (nonatomic, copy) SANLoginCompletionBlock completionBlock;
@property (nonatomic, weak) UIWebView *webView;

@end

@implementation SANLoginViewController

#pragma mark - Lifecycle

- (instancetype)initWithAuthorizeUrlString:(NSString *)authUrlString
                           completionBlock:(SANLoginCompletionBlock)completionBlock {
    self = [super init];
    if (self) {
        self.fullAuthUrlString = authUrlString;
        self.completionBlock = completionBlock;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    CGRect rect = self.view.bounds;
    rect.origin = CGPointMake(0, [UIApplication sharedApplication].statusBarFrame.size.height);
    
#warning webView было бы проще создавать в сториборде
    UIWebView *webView = [[UIWebView alloc] initWithFrame:rect];
    [self.view addSubview:webView];
    webView.delegate = self;
    self.webView = webView;
    
    NSURL *url = [NSURL URLWithString:self.fullAuthUrlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
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
   
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager POST:@"https://api.instagram.com/oauth/access_token"
                parameters:parameters
                   success:^(AFHTTPRequestOperation *operation, id responseObject) {
                       
                       NSString *token = responseObject[@"access_token"];
                       self.completionBlock(token);
                       self.webView.delegate = nil;
                   } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                      
                       self.completionBlock(nil);
                       self.webView.delegate = nil;
                   }];
        [self dismissViewControllerAnimated:YES completion:nil];
        return NO;
    }
    return YES;
}

@end
