//
//  TempViewController.m
//  InstagramLogin
//
//  Created by Admin on 05.10.15.
//  Copyright (c) 2015 Ignatenko_Alexandr. All rights reserved.
//

#import "TempViewController.h"

@interface TempViewController ()

@end

@implementation TempViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
/*
static NSString *const authUrlString = @" https://api.instagram.com/oauth/authorize/ ";
static NSString *const tokenUrlString = @" https://api.instagram.com/oauth/access_token/ ";

// ADD YOUR CLIENT ID AND SECRET HERE
static NSString *const clientID = @"xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
static NSString *const clientSecret = @"xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";

// YOU NEED A BAD URL HERE - THIS NEEDS TO MATCH YOUR URL SET UP FOR YOUR
// INSTAGRAM APP
static NSString *const redirectUri = @" http://mydomain.com/NeverGonnaFindMe/ ";

// CHANGE TO THE SCOPE YOU NEED ACCESS TO
static NSString *const scope = @"comments+relationships+likes";


// GRAB THE URL TRAFFIC TO CATCH THE ACCESS TOKEN OUT OF THE RETURN URL
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSURL *Url = [request URL];
    NSArray *UrlParts = [Url pathComponents];
    if ([[UrlParts objectAtIndex:(1)] isEqualToString:@"NeverGonnaFindMe"]) {
        // CONVERT TO STRING AN CLEAN
        NSString *urlResources = [Url resourceSpecifier];
        urlResources = [urlResources stringByReplacingOccurrencesOfString:@"?" withString:@""];
        urlResources = [urlResources stringByReplacingOccurrencesOfString:@"#" withString:@""];
        
        // SEPORATE OUT THE URL ON THE /
        NSArray *urlResourcesArray = [urlResources componentsSeparatedByString:@"/"];
        
        // THE LAST OBJECT IN THE ARRAY
        NSString *urlParamaters = [urlResourcesArray objectAtIndex:([urlResourcesArray count]-1)];
        
        // SEPORATE OUT THE URL ON THE &
        NSArray *urlParamatersArray = [urlParamaters componentsSeparatedByString:@"&"];
        if([urlParamatersArray count] == 1) {
            NSString *keyValue = [urlParamatersArray objectAtIndex:(0)];
            NSArray *keyValueArray = [keyValue componentsSeparatedByString:@"="];
            
            if([[keyValueArray objectAtIndex:(0)] isEqualToString:@"access_token"]) {
                // THE TOKEN IS NOW IN [keyValueArray objectAtIndex:(1)]
                // YAY WE HAVE AN ACCESS TOKEN TO SAVE IN THE KEYCHAIN OR USER DEFAULTS
                // SWITCH STORYBOARDS INTO THE MAIN APP
                UIStoryboard *settingsStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
                UIViewController *initialSettingsVC = [settingsStoryboard instantiateInitialViewController];
                initialSettingsVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
                [self presentModalViewController:initialSettingsVC animated:YES];
            }
        } else {
            // THERE WAS AN ERROR
        }
        [self dismissModalViewControllerAnimated:YES];
        return NO;
    }
    
    return YES;
}

// ACTIVITY INDICATOR
- (void)webViewDidStartLoad:(UIWebView *)webView{
    [_activityIndicator startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [_activityIndicator stopAnimating];
}

// INITIATE THE VIEW WITH THE CORRECT URL
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    NSString *fullAuthUrlString = [[NSString alloc]
                                   initWithFormat:@"%@/?client_id=%@&redirect_uri=%@&scope=%@&response_type=token&display=touch",
                                   authUrlString,
                                   clientID,
                                   redirectUri,
                                   scope
                                   ];
    NSURL *authUrl = [NSURL URLWithString:fullAuthUrlString];
    NSURLRequest *myRequest = [[NSURLRequest alloc] initWithURL:authUrl];
    [_webView loadRequest:myRequest];
}

 */
 
@end
