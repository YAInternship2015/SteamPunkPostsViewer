//
//  SPPTableViewController.m
//  SteamPunkPostsViewer
//
//  Created by Elias Tihonkov on 19.10.15.
//  Copyright (c) 2015 Tykhonkov Ilya. All rights reserved.
//

#import "SPPTableViewController.h"
#import "NSDateFormatter+SPPMyDateFormat.h"
#import "SPPTableViewCell.h"
#import "UIFont+SPPFontForMessages.h"



static NSString *reuseCellIdentifier = @"SPPTableCell";
//#warning текст надо перенести в Localizable.strings
//#warning формат надо перенести в категорию NSDateFormatter, в которой будет создаваться форматтер с этим форматом
//#warning имя шрифта и резмер надо перенести в категорию UIFont
//#warning из имени не ясно, к чему относится эта константа
#warning Создал две категории и перенес текст в Localizable.stringsLocalizable.strings, также преименовал константы и добавил  1 в константу
static NSInteger const kNumberBeforeEndOfPostsToStartRequest = 1;
static NSInteger const kMessageLableNumberOfLinesInText = 0;


@interface SPPTableViewController ()

@property (strong, nonatomic) SPPDataSource *dataSource;
@property (strong, nonatomic)  UILabel *messageLabel;

@end

@implementation SPPTableViewController

#pragma mark - TableView Methods

- (void)viewDidLoad{
    [super viewDidLoad];
   self.dataSource = [[SPPDataSource alloc] initWithDelegate:self];
    [self setupAndAddRefreshControll];
    [self showMessageLabel];
 
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource numberOfPostsInSection:section];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SPPTableViewCell *cell = [tableView  dequeueReusableCellWithIdentifier:reuseCellIdentifier forIndexPath:indexPath];
    // method  for inserting content in cell
    [cell setupCell:[self.dataSource postAtIndex:indexPath]];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell
                                         forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == ([self.dataSource numberOfPostsInSection:0] - kNumberBeforeEndOfPostsToStartRequest)) {
        [self.dataSource requestPostsToBottom];
    }
}

#pragma mark - SPPDataSourceDelegate Methods

- (void)insertObjectAtIndexPath: (NSIndexPath *) newIndexPath {
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationRight];
    [self.tableView endUpdates];
}

- (void)dataWasChanged {
    [self.tableView reloadData];
    if (self.refreshControl) {
        NSString *title = [NSString stringWithFormat:NSLocalizedString(@"Last update: %@", nil), [[NSDateFormatter createDateFormatter] stringFromDate:[NSDate date]]];
        NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:[UIColor whiteColor]
                                                                    forKey:NSForegroundColorAttributeName];
        NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
        self.refreshControl.attributedTitle = attributedTitle;
        [self.refreshControl endRefreshing];
    }
    
}

- (void)changeMessageLableForMessageThatSaysToLogin {
    _messageLabel.text = NSLocalizedString(@"Please Login First", nil);
}

#pragma mark - Private Methods

- (void)requestPostsToTop {
    [self.dataSource requestPostsToTop];
}

//#warning плохое имя метода
- (void)setupAndAddRefreshControll {
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor purpleColor];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self
                            action:@selector(requestPostsToTop)
                  forControlEvents:UIControlEventValueChanged];
}

- (void)showMessageLabel {
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;

    _messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width,self.view.bounds.size.height)];
    _messageLabel.text = NSLocalizedString(@"Pull down to refresh.", nil);
    _messageLabel.textColor = [UIColor blackColor];
    _messageLabel.numberOfLines = kMessageLableNumberOfLinesInText;
    _messageLabel.textAlignment = NSTextAlignmentCenter;
    _messageLabel.font = [UIFont fontForSPPTablViewMessage];
    [_messageLabel sizeToFit];
    self.tableView.backgroundView = _messageLabel;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
}

@end
