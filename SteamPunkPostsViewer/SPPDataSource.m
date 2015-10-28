//
//  SPPDataSource.m
//  SteamPunkPostsViewer
//
//  Created by Elias Tihonkov on 19.10.15.
//  Copyright (c) 2015 Tykhonkov Ilya. All rights reserved.
//

#import "SPPDataSource.h"
#import "SPPUserDataModel.h"
#import "SPPDataManager.h"

static NSString  * kPostIdKey= @"postID";

@interface SPPDataSource ()

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) SPPDataManager *dataManager;

@end

@implementation SPPDataSource

#pragma mark - Initiate
- (SPPDataSource *)initWithDelegate:(id<SPPModelsDataSourceDelegate>)delegate {
    self = [self init];
    if (self) {
        self.delegate = delegate;
    }
    return self;
}

#pragma mark - FetchResultsController

- (NSFetchedResultsController *)fetchedResultsController {
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    _fetchedResultsController = [SPPPostModel MR_fetchAllSortedBy: kPostIdKey
                                                        ascending:NO
                                                    withPredicate:nil
                                                          groupBy:nil
                                                         delegate:self];
    return _fetchedResultsController;
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
                                                                atIndexPath:(NSIndexPath *)indexPath
                                                              forChangeType:(NSFetchedResultsChangeType)type
                                                               newIndexPath:(NSIndexPath *)newIndexPath {
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.delegate insertObjectAtIndexPath:newIndexPath];
            break;
            
        case NSFetchedResultsChangeDelete:
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self.delegate dataWasChanged];
            break;
            
        case NSFetchedResultsChangeMove:
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.delegate dataWasChanged];
}

- (NSInteger)numberOfPostsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
}

- (SPPPostModel *)postAtIndex:(NSIndexPath *)indexPath {
    return [self.fetchedResultsController objectAtIndexPath:indexPath];
}

#pragma mark - Request Posts Methods

- (void)requestPostsToBottom {
    bool user = [SPPUserDataModel MR_hasAtLeastOneEntity];
    if (user) {
        [[SPPDataManager sharedManager] loadOldPosts];
    } else {
        [self.delegate changeMessageLableForMessageThatSaysToLogin];
    }
}

-(void)requestPostsToTop{
    bool user = [SPPUserDataModel MR_hasAtLeastOneEntity];
    if (user) {
        [[SPPDataManager sharedManager] loadRecentPosts];
    } else {
        [self.delegate changeMessageLableForMessageThatSaysToLogin];
    }
}

@end
