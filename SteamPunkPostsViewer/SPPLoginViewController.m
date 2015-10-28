//
//  SPPLoginViewController.m
//  SteamPunkPostsViewer
//
//  Created by Elias Tihonkov on 15.10.15.
//  Copyright (c) 2015 Tykhonkov Ilya. All rights reserved.
//

#import "SPPLoginViewController.h"
#import "SPPLoginAPIClient.h"
#import "NSString+SPPFetchVerifierFromRequest.h"


static NSString *const kClientID = @"33bc09c63c934786a26cde59f150b768";
static NSString *const kClientSecret = @"3e9ef127f8554d5f8f608eb1a16152da";
static NSString *const callback = @"http://steampunkpostsviewer.com/";
static NSString *const kBaseURL = @"https://api.instagram.com/";
static NSString *const TagsHostURL = @"https://api.instagram.com/v1/tags/";
static NSString *const kCallbackIdentifier = @"steampunkpostsviewer.com";


@interface SPPLoginViewController ()

@property (strong, nonatomic) SPPLoginAPIClient *LoginAPIClient;
@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation SPPLoginViewController

- (void)viewDidLoad {
    self.LoginAPIClient = [SPPLoginAPIClient new];
    [self.webView loadRequest:[self.LoginAPIClient oauthAuthorizeRequest]];
}

#pragma mark UIWebViewDelegate

- (BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request
                                                  navigationType:(UIWebViewNavigationType)navigationType {
    
    if ([[[request URL] host] isEqualToString:kCallbackIdentifier]) {
        NSString* verifier = [NSString fetchVerifierFromRequest:request];
        if (verifier) {
            [self.LoginAPIClient requestUserDataWithVerifier:verifier];
        } else {
            UIAlertView *alertView = [[UIAlertView alloc]
                                      initWithTitle:NSLocalizedString(@"SteamPunkPostViewer", nil)
                                      message:NSLocalizedString(@"Can't get verifier, maybe you have a problem with your internet connection.", nil)
                                      delegate:nil
                                      cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                      otherButtonTitles:nil];
            [alertView show];
        }
        [webView removeFromSuperview];
        
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:NSLocalizedString(@"SteamPunkPostViewer", nil)
                                  message:NSLocalizedString(@"You are loggedd in", nil)
                                  delegate:nil
                                  cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                  otherButtonTitles:nil];
        [alertView show];
        return NO;
    }
    return YES;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error wile connection", nil)
                                                    message:[NSString stringWithFormat:@"%@", error]
                                                   delegate:nil
                                          cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                          otherButtonTitles:nil];
    [alert show];
}

@end
