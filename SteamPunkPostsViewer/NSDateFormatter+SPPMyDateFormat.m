//
//  NSDateFormatter+SPPMyDateFormat.m
//  SteamPunkPostsViewer
//
//  Created by Elias Tihonkov on 26.10.15.
//  Copyright (c) 2015 Tykhonkov Ilya. All rights reserved.
//

#import "NSDateFormatter+SPPMyDateFormat.h"

static NSString *kDateFormat = @"MMM d, h:mm a";


@implementation NSDateFormatter (SPPMyDateFormat)

+ (NSDateFormatter *)createDateFormatter {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:kDateFormat];
    return formatter;
}

@end
