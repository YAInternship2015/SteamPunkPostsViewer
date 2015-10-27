//
//  SPPCollectionViewCell.h
//  SteamPunkPostsViewer
//
//  Created by Elias Tihonkov on 21.10.15.
//  Copyright (c) 2015 Tykhonkov Ilya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPPPostModel.h"

//#warning здесь те же замечания, что и в SPPTableViewCell

@interface SPPCollectionViewCell : UICollectionViewCell

- (void)setupCell:(SPPPostModel *)postModel;

@end
