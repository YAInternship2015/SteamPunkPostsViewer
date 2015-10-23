//
//  SPPTableViewCell.m
//  SteamPunkPostsViewer
//
//  Created by Elias Tihonkov on 19.10.15.
//  Copyright (c) 2015 Tykhonkov Ilya. All rights reserved.
//

#import "SPPTableViewCell.h"
#import "UIImageView+WebCache.h"

#warning не нужно хранить в константах имя картинки, лучше написать категорию на UIImage и реализовать в ней метод placeholderImage
static  NSString *kPlaceholderName = @"placeholder.png";

@implementation SPPTableViewCell

- (void)setupCell:(SPPPostModel *)postModel {

    
    self.postUserName.text = postModel.username;
    self.postCaptionText.text = postModel.captionText;
    [self.postImageView sd_setImageWithURL:[NSURL URLWithString:postModel.imageURL]
                          placeholderImage:[UIImage imageNamed:kPlaceholderName]];

    
}
@end
