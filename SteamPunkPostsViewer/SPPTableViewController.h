//
//  SPPTableViewController.h
//  SteamPunkPostsViewer
//
//  Created by Elias Tihonkov on 19.10.15.
//  Copyright (c) 2015 Tykhonkov Ilya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPPTableViewCell.h"
#import "SPPDataSource.h"

@interface SPPTableViewController : UITableViewController<UITableViewDataSource,
                                                          SPPModelsDataSourceDelegate,
                                                          UITableViewDelegate>



@end
