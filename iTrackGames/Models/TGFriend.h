//
//  TGFriend.h
//  iTrackGames
//
//  Created by Amanda Chappell on 6/8/13.
//  Copyright (c) 2013 Amanda Chappell. All rights reserved.
//

#import "TGUser.h"

typedef enum {
    TGFriendSourceFacebook
} TGFriendSource;

@interface TGFriend : TGUser

@property (nonatomic, assign) TGFriendSource friendSource;

@end
