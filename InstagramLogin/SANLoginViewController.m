//
//  SANLoginViewController.m
//  InstagramLogin
//
//  Created by Admin on 04.10.15.
//  Copyright (c) 2015 Ignatenko_Alexandr. All rights reserved.
//

#import "SANLoginViewController.h"
#import "SANAccessToken.h"

@interface SANLoginViewController () <UIWebViewDelegate>

@property (nonatomic, copy) SANLoginCompletionBlock completionBlock;
@property (nonatomic, weak) UIWebView *webView;

@end

@implementation SANLoginViewController

- (instancetype)initWithCompletionBlock:(SANLoginCompletionBlock)completionBlock {
    self = [super init];
    if (self) {
        self.completionBlock = completionBlock;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect rect = self.view.bounds;
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:rect];
    [self.view addSubview:webView];
    webView.delegate = self;
    self.webView = webView;
    
    NSString *urlString =  @"https://api.instagram.com/oauth/authorize/?"
                            "client_id=1b7349d77eb1421f9529a4728d201639&"
                            "redirect_uri=http://mydomain.com/NeverGonnaFindMe/&"
                            "response_type=code";
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

- (void)dealloc {
    self.webView.delegate = nil;
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    //http://www.mydomain.com/NeverGonnaFindMe/?code=acd052e41591483db169c3d9c52deca2
    
    
    if ([[[request URL] host] isEqualToString:@"www.mydomain.com"]) {
        NSLog(@"www");
        NSString *query = [[request URL] query];
        NSLog(@"%@", query);
        
        /*
         client_id: your client id
         client_secret: your client secret
         grant_type: authorization_code is currently the only supported value
         redirect_uri: the redirect_uri you used in the authorization request. Note: this has to be the same value as in the authorization request.
         code: the exact code you received during the authorization step.
        */
        
        NSString *urlString =  @"https://api.instagram.com/oauth/authorize/?"
                                "client_id=1b7349d77eb1421f9529a4728d201639&"
                                "client_secret=d7663572df134539813ec5845fd146ea&"
                                "grant_type=authorization_code&"
                                "redirect_uri=http://mydomain.com/NeverGonnaFindMe/"
                                "code=" //will CODE
        
        
        
        
        
        
        return NO;
    }
    NSLog(@"%@", [request URL]);
    return YES;
}

@end
