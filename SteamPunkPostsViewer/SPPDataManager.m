//
//  SPPDataManager.m
//  SteamPunkPostsViewer
//
//  Created by Elias Tihonkov on 19.10.15.
//  Copyright (c) 2015 Tykhonkov Ilya. All rights reserved.
//

#import "SPPDataManager.h"
#import <MagicalRecord/MagicalRecord.h>
#import "SPPUserDataModel.h"
#import "SPPPostModel.h"
#import "SPPNextMaxID.h"

static NSString const *kData = @"data";

@implementation SPPDataManager

#pragma mark Shared Manager

+ (SPPDataManager*)sharedManager {
    static SPPDataManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[SPPDataManager alloc] init];
    });
    return manager;
}

#pragma mark  Request Posts From DataAPI

- (void)loadRecentPosts {
   SPPDataAPI *dataAPI = [SPPDataAPI new];
    [dataAPI loadPosts:^(id responseObject) {
        __weak typeof(self) weakSelf = self;
        [weakSelf saveDownloadedPosts:responseObject];
    } withNextMaxID:false];
}

- (void)loadRecentPostsAndSetupNextMaxID {
    SPPDataAPI *dataAPI = [SPPDataAPI new];
    [dataAPI loadPosts:^(id responseObject) {
        __weak typeof(self) weakSelf = self;
        [weakSelf saveDownloadedPosts:responseObject];
        [weakSelf saveNextMaxID:responseObject];
    } withNextMaxID:false];
}


- (void)loadOldPosts {
    SPPDataAPI *dataAPI = [SPPDataAPI new];
    [dataAPI loadPosts:^(id responseObject) {
        __weak typeof(self) weakSelf = self;
        [weakSelf saveDownloadedPosts:responseObject];
        [weakSelf saveNextMaxID:responseObject];
    } withNextMaxID:true];
}

#pragma mark Save Methods

- (void)saveDownloadedPosts:(id)loadedData {
    NSInteger postIndex = 0;
    while (postIndex<[loadedData[kData] count]) {
        [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext){
            SPPPostModel *newPostModel = nil;
            NSArray *existedPosts = [SPPPostModel MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@" postID==%@ ", loadedData[kData][postIndex][@"id"]]];
            if ([existedPosts count]>0) {
                newPostModel=existedPosts[0];
            } else {
                newPostModel=[SPPPostModel MR_createEntityInContext:localContext];
            }
            newPostModel.captionText = loadedData[kData][postIndex][@"caption"][@"text"];
            newPostModel.postID = loadedData[kData][postIndex][@"id"];
            newPostModel.username = loadedData[kData][postIndex][@"user"][@"username"];
            newPostModel.imageURL = loadedData[kData][postIndex][@"images"][@"standard_resolution"][@"url"];
            
        }];
        postIndex++;
    }

}

- (void)saveNextMaxID:(id)loadedData {
    SPPNextMaxID *updateMaxID = [SPPNextMaxID MR_findFirst];
    if (updateMaxID) {
    updateMaxID.nextMaxID = loadedData[@"pagination"][@"next_max_id"];
    } else {
        updateMaxID = [SPPNextMaxID MR_createEntity];;
        updateMaxID.nextMaxID =  loadedData[@"pagination"][@"next_max_id"];
    }
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}

-(BOOL)isAnyDataLoaded{
    return [SPPPostModel MR_hasAtLeastOneEntity];
}
@end
