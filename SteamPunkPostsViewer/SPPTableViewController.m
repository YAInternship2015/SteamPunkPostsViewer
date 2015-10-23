//
//  SPPTableViewController.m
//  SteamPunkPostsViewer
//
//  Created by Elias Tihonkov on 19.10.15.
//  Copyright (c) 2015 Tykhonkov Ilya. All rights reserved.
//

#import "SPPTableViewController.h"

static NSString *reuseCellIdentifier = @"SPPTableCell";
#warning текст надо перенести в Localizable.strings
static NSString *kMessageLableText = @"Pull down to refresh.";
#warning формат надо перенести в категорию NSDateFormatter, в которой будет создаваться форматтер с этим форматом
static NSString *kDateFormat = @"MMM d, h:mm a";
#warning имя шрифта и резмер надо перенести в категорию UIFont
static NSString *kFontName = @"AppleSDGothicNeo-SemiBold";
#warning текст надо перенести в Localizable.strings
static NSString *kTitle = @"Last update: %@";
#warning из имени не ясно, к чему относится эта константа
static NSInteger kNumberOfLines = 0;
static NSInteger kFontSize = 40;


@interface SPPTableViewController ()

@property (strong, nonatomic) SPPDataSource *dataInstance;

@end

@implementation SPPTableViewController

#pragma mark - TableView Methods
- (void)viewDidLoad
{
    [super viewDidLoad];
   self.dataInstance =[[SPPDataSource alloc] initWithDelegate:self];
    [self initeatePullToRefresh];
    [self showMessageLabel];
 
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataInstance numberOfPostsInSection:section];
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SPPTableViewCell *cell = [tableView  dequeueReusableCellWithIdentifier:reuseCellIdentifier forIndexPath:indexPath];
    
    // metod  for loading content in cell
    [cell setupCell:[self.dataInstance postAtIndex:indexPath]];
#warning цифру 1 надо вынести в константы
    if (indexPath.row == ([self.dataInstance numberOfPostsInSection:0] - 1))    {
        [self.dataInstance requestPostsToBottom];
    }
    return cell;
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

#pragma mark - Private Methods

- (void)requestPostsToTop{
    [self.dataInstance requestPostsToTop];
    [self.tableView reloadData];
}

#warning плохое имя метода
- (void)initeatePullToRefresh {
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor purpleColor];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self
                            action:@selector(requestPostsToTop)
                  forControlEvents:UIControlEventValueChanged];

}

- (void)showMessageLabel{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;

    UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width,self.view.bounds.size.height)];
    messageLabel.text = kMessageLableText;
    messageLabel.textColor = [UIColor blackColor];
    messageLabel.numberOfLines = kNumberOfLines;
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.font = [UIFont fontWithName:kFontName size:kFontSize];
    [messageLabel sizeToFit];
    self.tableView.backgroundView = messageLabel;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
}

@end
