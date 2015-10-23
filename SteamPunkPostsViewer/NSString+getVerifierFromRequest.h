//
//  NSString+getVerifierFromRequest.h
//  SteamPunkPostsViewer
//
//  Created by Elias Tihonkov on 20.10.15.
//  Copyright (c) 2015 Tykhonkov Ilya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (getVerifierFromRequest)

#warning verifierFromRequest:. Get в именах методов крайне редко используются. Это же касается категории на NSDictionary
+ (NSString*)getVerifierFromRequest:(NSURLRequest *) request;

@end
