//
//  SPPDataAPI.m
//  SteamPunkPostsViewer
//
//  Created by Elias Tihonkov on 20.10.15.
//  Copyright (c) 2015 Tykhonkov Ilya. All rights reserved.
//

#import "SPPDataAPI.h"
#import "SPPPostModel.h"
#import "SPPUserDataModel.h"
#import <MagicalRecord/MagicalRecord.h>
#import <AFNetworking/AFNetworking.h>
#import "SPPDataManager.h"
#import "NSDictionary+getToken.h"

#warning static NSString *const, и также pathString - плохое имя переменной, неясно, что это за строка
NSString* pathString =  @"https://api.instagram.com/v1/tags/SteamPunk/media/recent";



@interface SPPDataAPI ()

@end


@implementation SPPDataAPI

+ (SPPDataAPI *)sharedManager {
    static SPPDataAPI *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[SPPDataAPI alloc] init];
    });
    return manager;
}

-(void) loadPosts:(void(^)(id responseObject))data withNextMaxID:(BOOL) boolIdentifier{
    NSDictionary * parameters=nil;
    if (boolIdentifier) {
        parameters = [NSDictionary getTokenAndMaxIDParameter];
    } else {
        parameters= [NSDictionary getTokenParameter];
    }
#warning поправьте выравнивание кода
AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
[manager GET:pathString parameters:parameters
                           success:^(AFHTTPRequestOperation *operation, id responseObject) {
    data(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    NSLog(@"Error: %@", error);
    }];
}

@end
