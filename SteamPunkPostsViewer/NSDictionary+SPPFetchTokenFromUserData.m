//
//  NSDictionary+FetchTokenFromUserData.m
//  SteamPunkPostsViewer
//
//  Created by Elias Tihonkov on 26.10.15.
//  Copyright (c) 2015 Tykhonkov Ilya. All rights reserved.
//

#import "NSDictionary+SPPFetchTokenFromUserData.h"
#import <MagicalRecord/MagicalRecord.h>
#import "SPPUserDataModel.h"
#import "SPPNextMaxID.h"

static NSString *kAccessToken = @"access_token";

@implementation NSDictionary (FetchTokenFromUserData)

+ (NSDictionary *)fetchTokenFromUserData {
    NSArray *user = [SPPUserDataModel MR_findAll];
    SPPUserDataModel *userModel = nil;
    if ([user count] > 0) {
        userModel = user[0];
    }
    NSDictionary *token = @{kAccessToken:userModel.accessToken};
        return token;
}

+ (NSDictionary *)fetchTokenWithNextMaxTagID {
    NSDictionary *token = [self fetchTokenFromUserData];
    SPPNextMaxID *maxID = [SPPNextMaxID MR_findFirst];
    
    NSMutableDictionary *tokenAndMaxIDParam = [NSMutableDictionary dictionary];
    [tokenAndMaxIDParam setValue:token[kAccessToken] forKey:kAccessToken];
    [tokenAndMaxIDParam setValue:maxID.nextMaxID forKey:@"max_tag_id"];
    return tokenAndMaxIDParam;
}

@end