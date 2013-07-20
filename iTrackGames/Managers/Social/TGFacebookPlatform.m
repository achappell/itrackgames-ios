//
//  TGFacebookPlatform.m
//  iTrackGames
//
//  Created by Amanda Chappell on 6/8/13.
//  Copyright (c) 2013 Amanda Chappell. All rights reserved.
//

#import "TGFacebookPlatform.h"
#import <FacebookSDK/FacebookSDK.h>
#import "TGUserManager.h"
#import <FacebookSDK/FBGraphUser.h>
#import "TGFriend.h"

typedef void(^TGFacebookSessionCompletionBlockType)(NSError *error);

@implementation TGFacebookPlatform

- (void)fetchFriendsWithCompletion:(TGSocialPlatformFriendsCompletionBlockType)completionBlock
{
    [self facebookSessionWithCompletion:^(NSError *error) {
        if (!error)
        {
            [FBRequestConnection startForMyFriendsWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                FBGraphObject *graphObject = result;
                
                NSArray *facebookFriendsList = [graphObject objectForKey:@"data"];
                
                NSMutableArray *friendsList = [NSMutableArray array];
                
                for (id<FBGraphUser> user in facebookFriendsList)
                {
                    TGFriend *friend = [[TGFriend alloc] init];
                    friend.firstName = [user first_name];
                    friend.lastName = [user last_name];
                    
                    [friendsList addObject:friend];
                }
                
                if (completionBlock)
                    completionBlock(friendsList, nil);
            }];
        }
        else
        {
            if (completionBlock)
                completionBlock(nil, error);
        }
    }];
}

- (void)facebookSessionWithCompletion:(TGFacebookSessionCompletionBlockType)completionBlock
{
    NSArray *permissions =
    [NSArray arrayWithObjects:@"email", nil];
    if ([[FBSession activeSession] state] == FBSessionStateCreated || [[FBSession activeSession] state] == FBSessionStateCreatedOpening || [[FBSession activeSession] state] == FBSessionStateCreatedTokenLoaded || [[FBSession activeSession] state] == FBSessionStateClosed)
    {
        [FBSession openActiveSessionWithReadPermissions:permissions allowLoginUI:YES completionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
            if (completionBlock)
                completionBlock(nil);
        }];
    }
    else if([[FBSession activeSession] state] == FBSessionStateOpen || [[FBSession activeSession] state] == FBSessionStateOpenTokenExtended)
    {
        if (completionBlock)
            completionBlock(nil);
    }
    else if([[FBSession activeSession] state] == FBSessionStateClosedLoginFailed)
    {
        if (completionBlock)
            completionBlock([NSError errorWithDomain:nil code:0 userInfo:nil]);
    }
}



@end
