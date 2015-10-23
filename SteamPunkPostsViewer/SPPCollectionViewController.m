//
//  SPPCollectionViewController.m
//  SteamPunkPostsViewer
//
//  Created by Elias Tihonkov on 19.10.15.
//  Copyright (c) 2015 Tykhonkov Ilya. All rights reserved.
//

#import "SPPCollectionViewController.h"

static NSString *reuseCellIdentifier = @"SPPCollectionCell";
#warning текст в Localizable.strings
static NSString *kMessageLableText = @"Pull down to refresh.";
#warning формат в категорию NSDateFormatter
static NSString *kDateFormat = @"MMM d, h:mm a";
#warning шрифт в категорию UIFont
static NSString *kFontName = @"AppleSDGothicNeo-SemiBold";
#warning текст в Localizable.strings
static NSString *kTitle = @"Last update: %@";


@interface SPPCollectionViewController ()

#warning плохое имя свойства
@property (strong,nonatomic) SPPDataSource *dataInstance;

@property (strong, nonatomic) UIRefreshControl *refreshControl;

@end

@implementation SPPCollectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.collectionView reloadData];
    self.dataInstance =[[SPPDataSource alloc] initWithDelegate:self];
    [self initeatePullToRefresh];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section; {
    return [self.dataInstance numberOfPostsInSection:section];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath; {
    SPPCollectionViewCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:reuseCellIdentifier
                                                                           forIndexPath:indexPath];
    
    [cell setupCell:[self.dataInstance postAtIndex:indexPath]];
#warning цифра 1 должна быть в константах
    if (indexPath.row == ([self.dataInstance numberOfPostsInSection:0] - 1))    {
        [self.dataInstance requestPostsToBottom];
    }
    return cell;
}



-(void) insertObjectAtIndexPath: (NSIndexPath *) newIndexPath{
#warning в этом месте приложение крешится в режиме с collectionView, когда добавляются новые айтемы
    [self.collectionView insertItemsAtIndexPaths:@[newIndexPath]];
}


#pragma mark Private Methods
- (void)requestPostsToTop{
    [self.dataInstance requestPostsToTop];
    [self.collectionView reloadData];
}

#warning плохое имя метода
- (void)initeatePullToRefresh {
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor purpleColor];
    self.refreshControl.tintColor = [UIColor whiteColor];
    self.refreshControl.contentScaleFactor=2.0;
    [self.refreshControl addTarget:self
                            action:@selector(requestPostsToTop)
                  forControlEvents:UIControlEventValueChanged];
    [self.collectionView addSubview:self.refreshControl];
}


- (void) dataWasChanged {
    
    [self.collectionView reloadData];

    if (self.refreshControl) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:kDateFormat];
        NSString *title = [NSString stringWithFormat:kTitle, [formatter stringFromDate:[NSDate date]]];
        NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:[UIColor whiteColor]
                                                                    forKey:NSForegroundColorAttributeName];
        NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
        self.refreshControl.attributedTitle = attributedTitle;
        
        [self.refreshControl endRefreshing];
    }

}


@end
