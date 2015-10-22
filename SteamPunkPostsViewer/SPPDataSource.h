//
//  SPPDataSource.h
//  SteamPunkPostsViewer
//
//  Created by Elias Tihonkov on 19.10.15.
//  Copyright (c) 2015 Tykhonkov Ilya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MagicalRecord/MagicalRecord.h>
#import "SPPPostModel.h"


@protocol SPPModelsDataSourceDelegate <NSObject>

@optional
- (void)dataWasChanged;
@required
- (void)insertObjectAtIndexPath:(NSIndexPath *)newIndexPath;

@end

@interface SPPDataSource : NSObject <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) id<SPPModelsDataSourceDelegate>delegate;

- (SPPDataSource*)initWithDelegate:(id<SPPModelsDataSourceDelegate>)delegate;
- (SPPPostModel*)postAtIndex:(NSIndexPath*)indexPath;
- (NSInteger)numberOfPostsInSection:(NSInteger)section;
- (void)requestPostsToBottom;
- (void)requestPostsToTop;

@end
