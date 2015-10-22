//
//  SPPUserDataModel.h
//  SteamPunkPostsViewer
//
//  Created by Elias Tihonkov on 20.10.15.
//  Copyright (c) 2015 Tykhonkov Ilya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface SPPUserDataModel : NSManagedObject

@property (nonatomic, retain) NSString * accessToken;
@property (nonatomic, retain) NSString * fullName;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSString * profilePicture;
@property (nonatomic, retain) NSString * userID;

@end
