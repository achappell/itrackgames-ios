//
//  TGSocialPlatform.h
//  iTrackGames
//
//  Created by Amanda Chappell on 6/8/13.
//  Copyright (c) 2013 Amanda Chappell. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^TGSocialPlatformFriendsCompletionBlockType)(NSArray *friends, NSError *error);

@protocol TGSocialPlatform <NSObject>

- (void)fetchFriendsWithCompletion:(TGSocialPlatformFriendsCompletionBlockType)completionBlock;

@end

@interface TGSocialPlatform : NSObject <TGSocialPlatform>

@end
