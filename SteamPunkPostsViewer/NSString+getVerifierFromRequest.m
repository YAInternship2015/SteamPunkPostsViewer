//
//  NSString+getVerifierFromRequest.m
//  SteamPunkPostsViewer
//
//  Created by Elias Tihonkov on 20.10.15.
//  Copyright (c) 2015 Tykhonkov Ilya. All rights reserved.
//

#import "NSString+getVerifierFromRequest.h"

@implementation NSString (getVerifierFromRequest)

+ (NSString*)getVerifierFromRequest:(NSURLRequest *) request{
    NSString *verifier = nil;
    NSArray* url = [[[request URL] query] componentsSeparatedByString:@"&"];
    for (NSString* param in url) {
        NSArray* keyValue = [param componentsSeparatedByString:@"="];
        NSString* key = [keyValue objectAtIndex:0];
        if ([key isEqualToString:@"code"]) {
            verifier = [keyValue objectAtIndex:1];
            break;
        }
    }
    return verifier;
}

@end
