//
//  SPPTableViewCell.m
//  SteamPunkPostsViewer
//
//  Created by Elias Tihonkov on 19.10.15.
//  Copyright (c) 2015 Tykhonkov Ilya. All rights reserved.
//

#import "SPPTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "UIImage+SPPPlaceholder.h"


//#warning не нужно хранить в константах имя картинки, лучше написать категорию на UIImage и реализовать в ней метод placeholderImage
@interface SPPTableViewCell ()

@property (strong, nonatomic) IBOutlet UIImageView *postImageView;
@property (strong, nonatomic) IBOutlet UILabel *postCaptionText;
@property (strong, nonatomic) IBOutlet UILabel *postUserName;

@end

@implementation SPPTableViewCell

- (void)setupCell:(SPPPostModel *)postModel{
    self.postUserName.text = postModel.username;
    self.postCaptionText.text = postModel.captionText;
    [self.postImageView sd_setImageWithURL:[NSURL URLWithString:postModel.imageURL]
                          placeholderImage:[UIImage placeholderImage]];
}
@end
