//
//  SPPAppDelegate.m
//  SteamPunkPostsViewer
//
//  Created by Elias Tihonkov on 14.10.15.
//  Copyright (c) 2015 Tykhonkov Ilya. All rights reserved.
//

#import "SPPAppDelegate.h"
#import <MagicalRecord/MagicalRecord.h>
static NSString *kCDSName = @"SteamPunkPostsViewer";


@implementation SPPAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [MagicalRecord setupCoreDataStackWithStoreNamed:kCDSName];
    return YES;
}



							
@end
