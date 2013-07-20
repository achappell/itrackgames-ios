//
//  TGFriendsDataSource.m
//  iTrackGames
//
//  Created by Amanda Chappell on 6/8/13.
//  Copyright (c) 2013 Amanda Chappell. All rights reserved.
//

#import "TGFriendsDataSource.h"
#import "TGSocialManager.h"

@interface TGFriendsDataSource()

@property (nonatomic, strong, readwrite) NSArray *friends;

@end

@implementation TGFriendsDataSource

- (void)reloadData
{
    [self startLoading];
    
    [[TGSocialManager sharedManager] fetchFriendsWithCompletion:^(NSArray *friends, NSError *error) {
        
        if (!error)
            self.friends = friends;
        
        [self endLoadingWithError:error];
    }];
}

@end
