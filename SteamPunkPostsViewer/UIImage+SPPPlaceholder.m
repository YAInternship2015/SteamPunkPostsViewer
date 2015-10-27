//
//  UIImage+Placeholder.m
//  SteamPunkPostsViewer
//
//  Created by Elias Tihonkov on 26.10.15.
//  Copyright (c) 2015 Tykhonkov Ilya. All rights reserved.
//

#import "UIImage+SPPPlaceholder.h"


static  NSString *kPlaceholderName = @"placeholder.png";


@implementation UIImage (Placeholder)

+ (UIImage *)placeholderImage {
    return [UIImage imageNamed:kPlaceholderName];
}


@end
