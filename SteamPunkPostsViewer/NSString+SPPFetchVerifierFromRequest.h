//
//  NSString+FetchVerifierFromRequest.h
//  SteamPunkPostsViewer
//
//  Created by Elias Tihonkov on 26.10.15.
//  Copyright (c) 2015 Tykhonkov Ilya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (FetchVerifierFromRequest)

+ (NSString *)fetchVerifierFromRequest:(NSURLRequest *) request;

@end
