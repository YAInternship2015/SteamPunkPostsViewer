//
//  SPPContainerViewController.m
//  SteamPunkPostsViewer
//
//  Created by Elias Tihonkov on 21.10.15.
//  Copyright (c) 2015 Tykhonkov Ilya. All rights reserved.
//

#import "SPPContainerViewController.h"
#import "SPPTableViewController.h"
#import "SPPCollectionViewController.h"
#import "SPPDataManager.h"


//warning тексты надо перенести в Localizable.strings
@interface SPPContainerViewController ()

@property (strong, nonatomic) SPPTableViewController *tableView;
@property (strong, nonatomic) SPPCollectionViewController *collectionView;
@property (strong, nonatomic) IBOutlet UIView *containerView;

- (IBAction)switchViewController:(id)sender;

@end

@implementation SPPContainerViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.tableView = [self.storyboard instantiateViewControllerWithIdentifier:                                      NSStringFromClass([SPPTableViewController class])];
    self.collectionView = [self.storyboard instantiateViewControllerWithIdentifier:                             NSStringFromClass([SPPCollectionViewController class])];
    

    [self addChildViewController:self.tableView];
    [self addChildViewController:self.collectionView];
    [_containerView addSubview:self.tableView.view];
}

//#warning плохое имя метода
- (IBAction)switchViewController:(id)sender {
//#warning fromViewController, toViewController
    UIViewController *fromViewController, *toViewController;
    if ([self.tableView.view isDescendantOfView: self.view])   {
        fromViewController = self.tableView;
        toViewController = self.collectionView;
    } else   {
        fromViewController = self.collectionView;
        toViewController = self.tableView;
    }
    [self transitionFromViewController:fromViewController
                      toViewController:toViewController
                              duration:0.3
                               options:UIViewAnimationOptionTransitionCrossDissolve
                            animations:nil
                            completion:nil];
}

@end
