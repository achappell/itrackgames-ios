//
//  TGSocialManager.h
//  iTrackGames
//
//  Created by Amanda Chappell on 6/8/13.
//  Copyright (c) 2013 Amanda Chappell. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TGSocialPlatform;

typedef void(^TGSocialPlatformFriendsCompletionBlockType)(NSArray *friends, NSError *error);

@interface TGSocialManager : NSObject

@property (nonatomic, strong, readonly) NSArray *socialPlatforms;

+(TGSocialManager *) sharedManager;
- (void)addSocialPlatform:(TGSocialPlatform *)platform;
- (void)fetchFriendsWithCompletion:(TGSocialPlatformFriendsCompletionBlockType)completionBlock;;

@end
