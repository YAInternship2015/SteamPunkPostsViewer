//
//  SPPDataManager.h
//  SteamPunkPostsViewer
//
//  Created by Elias Tihonkov on 19.10.15.
//  Copyright (c) 2015 Tykhonkov Ilya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPPDataAPIClient.h"

typedef void (^SPPUserDataBlock)(id userData);

@interface SPPDataManager : NSObject

+ (SPPDataManager *)sharedManager;
- (void)loadRecentPosts;
- (void)loadRecentPostsAndSetupNextMaxID;
- (void)loadOldPosts;
- (BOOL)isAnyDataLoaded;

@end
