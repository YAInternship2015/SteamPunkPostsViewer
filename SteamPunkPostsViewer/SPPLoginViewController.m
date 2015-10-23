//
//  SPPLoginViewController.m
//  SteamPunkPostsViewer
//
//  Created by Elias Tihonkov on 15.10.15.
//  Copyright (c) 2015 Tykhonkov Ilya. All rights reserved.
//

#import "SPPLoginViewController.h"
#import "SPPLoginAPI.h"
#import "NSString+getVerifierFromRequest.h"

static NSString *kClientID = @"33bc09c63c934786a26cde59f150b768";
static NSString *kClientSecret = @"3e9ef127f8554d5f8f608eb1a16152da";
static NSString *callback = @"http://steampunkpostsviewer.com/";
static NSString *kBaseURL= @"https://api.instagram.com/";
static NSString *TagsHostURL = @"https://api.instagram.com/v1/tags/";
#warning все тексты надо вынести в Localizable.strings
static NSString *kNSlogMessage = @"Can't get verifier";
static NSString *kAllerMessage = @"You are loggedd in";
static NSString *kAllertTitle = @"SteamPunkPostViewer";
static NSString *kCancelButtonTitle = @"OK";
static NSString *kConectionErrorTitle = @"Error wile connection";
static NSString *kCallbackIdentifier = @"steampunkpostsviewer.com";

@interface SPPLoginViewController ()

@property (strong, nonatomic) SPPLoginAPI *loginAPI;

@end

@implementation SPPLoginViewController

- (void)viewDidLoad {
    self.loginAPI=[SPPLoginAPI new];
    [self.webView loadRequest:[self.loginAPI oauthAuthorizeRequest]];
}

#warning этот метод надо удалить
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UIWebViewDelegate

- (BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    if ([[[request URL] host] isEqualToString:kCallbackIdentifier]) {
        NSString* verifier =[NSString getVerifierFromRequest:request];
        if (verifier) {
            [self.loginAPI requestUserDataWith:verifier];
        } else {
            NSLog(@"%@",kNSlogMessage);
        }
        [webView removeFromSuperview];
#warning зачем преобразовывать NSString в NSString?
               NSString *message = [NSString stringWithFormat:@"%@",kAllerMessage];
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:kAllertTitle
                                  message:message
                                  delegate:nil
                                  cancelButtonTitle:kCancelButtonTitle
                                  otherButtonTitles:nil];
        [alertView show];
        return NO;
    }
    return YES;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kConectionErrorTitle
                                                    message:[NSString stringWithFormat:@"%@", error]
                                                   delegate:nil
                                          cancelButtonTitle:kCancelButtonTitle
                                          otherButtonTitles:nil];
    [alert show];
}

@end
