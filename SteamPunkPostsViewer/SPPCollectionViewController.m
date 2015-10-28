//
//  SPPCollectionViewController.m
//  SteamPunkPostsViewer
//
//  Created by Elias Tihonkov on 19.10.15.
//  Copyright (c) 2015 Tykhonkov Ilya. All rights reserved.
//

#import "SPPCollectionViewController.h"
#import "SPPCollectionViewCell.h"
#import "NSDateFormatter+SPPMyDateFormat.h"
#import "UIFont+SPPFontForMessages.h"


static NSString *reuseCellIdentifier = @"SPPCollectionCell";
static NSInteger kLastCellToRequestNextPackOfPosts = 1;
static NSInteger const kMessageLableNumberOfLinesInText = 0;

@interface SPPCollectionViewController ()

@property (strong, nonatomic) SPPDataSource *dataSource;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (strong, nonatomic)  UILabel *messageLabel;
@end

@implementation SPPCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource =[[SPPDataSource alloc] initWithDelegate:self];
    [self setupRefreshControl];
    self.collectionView.alwaysBounceVertical = YES;
    [self showMessageLabel];

}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section; {
    return [self.dataSource numberOfPostsInSection:section];

}


- (UICollectionViewCell*)collectionView:(UICollectionView*)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath; {
    SPPCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseCellIdentifier
                                                                           forIndexPath:indexPath];
    
    if (indexPath.row == ([self.dataSource numberOfPostsInSection:0] - kLastCellToRequestNextPackOfPosts))    {
        [self.dataSource requestPostsToBottom];
    }
    [cell setupCell:[self.dataSource postAtIndex:indexPath]];
    return cell;
}

#pragma mark - SPPDataSourceDelegate Methods

-(void)insertObjectAtIndexPath:(NSIndexPath *)newIndexPath {
    [self.collectionView reloadData];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _messageLabel.text = @"";
    });

}
- (void)changeMessageLableForMessageThatSaysToLogin {
    _messageLabel.text = NSLocalizedString(@"Please Login First", nil);
    [self dataWasChanged];
}


#pragma mark Private Methods
- (void)requestPostsToTop{
    [self.dataSource requestPostsToTop];
}

- (void)setupRefreshControl {
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor purpleColor];
    self.refreshControl.tintColor = [UIColor whiteColor];
    self.refreshControl.contentScaleFactor = 2.0;
    [self.refreshControl addTarget:self
                            action:@selector(requestPostsToTop)
                  forControlEvents:UIControlEventValueChanged];
    [self.collectionView addSubview:self.refreshControl];
}

- (void)dataWasChanged {
    if (self.refreshControl) {
        NSString *title = [NSString stringWithFormat:NSLocalizedString(@"Last update: %@", nil), [[NSDateFormatter createDateFormatter] stringFromDate:[NSDate date]]];
        NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:[UIColor whiteColor]
                                                                    forKey:NSForegroundColorAttributeName];
        NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
        self.refreshControl.attributedTitle = attributedTitle;
        [self.refreshControl endRefreshing];
    }
    [self.collectionView reloadData];

}

- (void)showMessageLabel {
    _messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width,self.view.bounds.size.height)];
    _messageLabel.text = NSLocalizedString(@"Pull down to refresh.", nil);
    _messageLabel.textColor = [UIColor blackColor];
    _messageLabel.numberOfLines = kMessageLableNumberOfLinesInText;
    _messageLabel.textAlignment = NSTextAlignmentCenter;
    _messageLabel.font = [UIFont fontForSPPTablViewMessage];
    [_messageLabel sizeToFit];
    self.collectionView.backgroundView = _messageLabel;
}

@end


