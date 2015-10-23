//
//  SPPLoginAPI.h
//  SteamPunkPostsViewer
//
//  Created by Elias Tihonkov on 20.10.15.
//  Copyright (c) 2015 Tykhonkov Ilya. All rights reserved.
//


#import <Foundation/Foundation.h>

#warning лучше SPPLoginAPIClient
@interface SPPLoginAPI : NSObject


- (NSURLRequest*)oauthAuthorizeRequest;
#warning requestUserDataWithVerifier:
- (void)requestUserDataWith:(NSString*)verifier;

@end
