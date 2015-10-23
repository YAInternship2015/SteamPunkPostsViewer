//
//  SPPDataAPI.h
//  SteamPunkPostsViewer
//
//  Created by Elias Tihonkov on 20.10.15.
//  Copyright (c) 2015 Tykhonkov Ilya. All rights reserved.
//

#import <Foundation/Foundation.h>

#warning лучше SPPDataAPIClient
@interface SPPDataAPI : NSObject

#warning + (SPPDataAPI *)sharedManager;
+ (SPPDataAPI*)sharedManager;
#warning не хватает пробела после "-", и также тип блока надо объявлять через typedef. Еще стоит отметить, что блоки предпочтительнее делать идут последними параметрами. И на счет NextMaxID:(BOOL)boolIdentifier - NextMaxID звучит как число или строка, но никак не bool, переименуйте параметр, чтобы было понятно, что он значит
-(void)loadPosts:(void(^)(id responseObject))data withNextMaxID:(BOOL)boolIdentifier;

@end
