//
//  SPPDataAPI.h
//  SteamPunkPostsViewer
//
//  Created by Elias Tihonkov on 20.10.15.
//  Copyright (c) 2015 Tykhonkov Ilya. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SPPDataAPI : NSObject

+ (SPPDataAPI*)sharedManager;
-(void)loadPosts:(void(^)(id responseObject))data withNextMaxID:(BOOL)boolIdentifier;

@end
