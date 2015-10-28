//
//  SPPCollectionViewCell.m
//  SteamPunkPostsViewer
//
//  Created by Elias Tihonkov on 21.10.15.
//  Copyright (c) 2015 Tykhonkov Ilya. All rights reserved.
//

#import "SPPCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "UIImage+SPPPlaceholder.h"


@interface SPPCollectionViewCell ()

@property (strong, nonatomic) IBOutlet UIImageView *postImageView;

@end

@implementation SPPCollectionViewCell

- (void)setupCell:(SPPPostModel *)postModel {
    [self.postImageView sd_setImageWithURL:[NSURL URLWithString:postModel.imageURL]
                          placeholderImage:[UIImage placeholderImage]];
}

@end
