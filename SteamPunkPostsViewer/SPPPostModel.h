//
//  SPPPostModel.h
//  SteamPunkPostsViewer
//
//  Created by Elias Tihonkov on 20.10.15.
//  Copyright (c) 2015 Tykhonkov Ilya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface SPPPostModel : NSManagedObject

@property (nonatomic, retain) NSString * captionText;
@property (nonatomic, retain) NSString * imageURL;
@property (nonatomic, retain) NSString * postID;
@property (nonatomic, retain) NSString * username;

@end
