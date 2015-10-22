//
//  SPPLoginViewController.h
//  SteamPunkPostsViewer
//
//  Created by Elias Tihonkov on 15.10.15.
//  Copyright (c) 2015 Tykhonkov Ilya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPPAppDelegate.h"



@class SPPPostModel;

@interface SPPLoginViewController : UIViewController<UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *webView;


@end
