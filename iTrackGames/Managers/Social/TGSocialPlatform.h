//
//  TGSocialPlatform.h
//  iTrackGames
//
//  Created by Amanda Chappell on 6/8/13.
//  Copyright (c) 2013 Amanda Chappell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TGSocialManager.h"

@protocol TGSocialPlatform <NSObject>

- (void)fetchFriendsWithCompletion:(TGSocialPlatformFriendsCompletionBlockType)completionBlock;

@end

@interface TGSocialPlatform : NSObject <TGSocialPlatform>

@end
