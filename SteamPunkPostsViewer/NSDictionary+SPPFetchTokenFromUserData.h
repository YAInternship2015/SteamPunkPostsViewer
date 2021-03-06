//
//  NSDictionary+FetchTokenFromUserData.h
//  SteamPunkPostsViewer
//
//  Created by Elias Tihonkov on 26.10.15.
//  Copyright (c) 2015 Tykhonkov Ilya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (FetchTokenFromUserData)

+ (NSDictionary *)fetchTokenFromUserData;
+ (NSDictionary *)fetchTokenWithNextMaxTagID;

@end
