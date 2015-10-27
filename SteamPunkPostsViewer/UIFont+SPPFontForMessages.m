//
//  UIFont+FontForMessages.m
//  SteamPunkPostsViewer
//
//  Created by Elias Tihonkov on 26.10.15.
//  Copyright (c) 2015 Tykhonkov Ilya. All rights reserved.
//

#import "UIFont+SPPFontForMessages.h"

static NSString *kFontName = @"AppleSDGothicNeo-SemiBold";
static NSInteger const kMessageLableTextFontSize = 40;


@implementation UIFont (FontForMessages)

+ (UIFont *)fontForSPPTablViewMessage {
    return [UIFont fontWithName:kFontName size:kMessageLableTextFontSize];
}

@end
