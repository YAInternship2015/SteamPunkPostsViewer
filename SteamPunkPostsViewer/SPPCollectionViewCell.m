//
//  SPPCollectionViewCell.m
//  SteamPunkPostsViewer
//
//  Created by Elias Tihonkov on 21.10.15.
//  Copyright (c) 2015 Tykhonkov Ilya. All rights reserved.
//

#import "SPPCollectionViewCell.h"
#import "UIImageView+WebCache.h"

static  NSString *kPlaceholderName = @"placeholder.png";

@implementation SPPCollectionViewCell

- (void)setupCell:(SPPPostModel *)postModel {
    [self.postImageView sd_setImageWithURL:[NSURL URLWithString:postModel.imageURL]
                          placeholderImage:[UIImage imageNamed:kPlaceholderName]];

}

@end
