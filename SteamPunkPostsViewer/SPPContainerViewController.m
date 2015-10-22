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

static NSString *kAllerMessage = @"First load some posts";
static NSString *kAllertTitle = @"SteamPunkPostViewer";
static NSString *kCancelButtonTitle = @"OK";



@interface SPPContainerViewController ()

@property (strong, nonatomic) SPPTableViewController *tableView;
@property (strong, nonatomic) SPPCollectionViewController *collectionView;
@property (strong, nonatomic) IBOutlet UIView *containerView;

- (IBAction)switcher:(id)sender;

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




- (IBAction)switcher:(id)sender {
    if ([[SPPDataManager sharedManager] isAnyDataLoaded]) {
    UIViewController *fromView, *toView;
    if ([self.tableView.view isDescendantOfView: self.view])   {
        fromView = self.tableView;
        toView = self.collectionView;
    } else   {
        fromView = self.collectionView;
        toView = self.tableView;
    }
    [self transitionFromViewController:fromView
                      toViewController:toView
                              duration:0.5
                               options:UIViewAnimationOptionTransitionCrossDissolve
                            animations:nil
                            completion:nil];
#warning Сделал этот Aller как временную меру из за бага загрузки постов в пустом CollectionView, как разберусь в чем причина и устраню, уберу этот Aller.
        } else {
        NSString *message = [NSString stringWithFormat:@"%@",kAllerMessage];
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:kAllertTitle
                                  message:message
                                  delegate:nil
                                  cancelButtonTitle:kCancelButtonTitle
                                  otherButtonTitles:nil];
        [alertView show];
    }
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
