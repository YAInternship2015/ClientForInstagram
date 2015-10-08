//
//  SANLoginViewController.m
//  InstagramLogin
//
//  Created by Admin on 04.10.15.
//  Copyright (c) 2015 Ignatenko_Alexandr. All rights reserved.
//

#import "SANLoginViewController.h"
#import "SANAccessToken.h"
#import "AFNetworking.h"

@interface SANLoginViewController () <UIWebViewDelegate>

@property (nonatomic, copy) SANLoginCompletionBlock completionBlock;
@property (nonatomic, weak) UIWebView *webView;

@end

@implementation SANLoginViewController

static NSString *const authUrlString  = @"https://api.instagram.com/oauth/authorize/";
static NSString *const tokenUrlString = @"https://api.instagram.com/oauth/access_token/";
static NSString *const clientID       = @"1b7349d77eb1421f9529a4728d201639";
static NSString *const clientSecret   = @"d7663572df134539813ec5845fd146ea";
static NSString *const redirectUri    = @"http://mydomain.com/NeverGonnaFindMe/";
//static NSString *const scope          = @"comments+relationships+likes";

- (instancetype)initWithCompletionBlock:(SANLoginCompletionBlock)completionBlock {
    self = [super init];
    if (self) {
        self.completionBlock = completionBlock;
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    CGRect rect = self.view.bounds;
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:rect];
    [self.view addSubview:webView];
    webView.delegate = self;
    self.webView = webView;
    
    NSString *fullAuthUrlString = [[NSString alloc]
                                   initWithFormat:@"%@?client_id=%@&redirect_uri=%@&response_type=code",
                                                  authUrlString, clientID, redirectUri];
    
    NSURL *url = [NSURL URLWithString:fullAuthUrlString];
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
                                     @"client_id"     : clientID,
                                     @"client_secret" : clientSecret,
                                     @"grant_type"    : @"authorization_code",
                                     @"redirect_uri"  : redirectUri,
                                     @"code" : code
                                     };
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        [manager POST:@"https://api.instagram.com/oauth/access_token"
           parameters:parameters
              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                  NSLog(@"JSON: %@", responseObject);
                  
                  /*
                   "access_token" = "1565503607.1b7349d.19b14c7410164d55b21e63c83072ecaa";
                   user =     {
                   bio = "";
                   "full_name" = "\U0410\U043b\U0435\U043a\U0441\U0430\U043d\U0434\U0440";
                   id = 1565503607;
                   "profile_picture" = "http://images.ak.instagram.com/profiles/anonymousUser.jpg";
                   username = ighnatenko;
                   website = "";
                   };
                   */
                  
                  SANAccessToken *token = [[SANAccessToken alloc] initWithToken:responseObject[@"access_token"]];
                  self.completionBlock(token);
                  
              } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                  NSLog(@"Error: %@", error);
              }];
        self.webView.delegate = nil;
        [self dismissViewControllerAnimated:YES completion:^{
           
        }];
        return NO;
    }
    return YES;
}

@end
