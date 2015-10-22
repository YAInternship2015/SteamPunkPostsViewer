//
//  NSDictionary+getToken.h
//  SteamPunkPostsViewer
//
//  Created by Elias Tihonkov on 20.10.15.
//  Copyright (c) 2015 Tykhonkov Ilya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (getToken)

+ (NSDictionary*)getTokenParameter;
+ (NSDictionary*)getTokenAndMaxIDParameter;

@end
