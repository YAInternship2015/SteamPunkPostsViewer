//
//  SPPTableViewCell.h
//  SteamPunkPostsViewer
//
//  Created by Elias Tihonkov on 19.10.15.
//  Copyright (c) 2015 Tykhonkov Ilya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPPPostModel.h"

@interface SPPTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *postImageView;

@property (strong, nonatomic) IBOutlet UILabel *postCaptionText;

@property (strong, nonatomic) IBOutlet UILabel *postUserName;

- (void)setupCell:(SPPPostModel *)postModel;

@end
