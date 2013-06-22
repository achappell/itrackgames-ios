//
//  TGSocialManager.m
//  iTrackGames
//
//  Created by Amanda Chappell on 6/8/13.
//  Copyright (c) 2013 Amanda Chappell. All rights reserved.
//

#import "TGSocialManager.h"
#import "TGSocialPlatform.h"

@interface TGSocialManager()
{
    NSMutableArray *_socialPlatforms;
}

@property (nonatomic, strong, readwrite) NSMutableArray *socialPlatforms;

@end

static TGSocialManager *_sharedManager;

@implementation TGSocialManager

+(TGSocialManager *) sharedManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!_sharedManager)
        {
            _sharedManager = [[TGSocialManager alloc] init];
        }
    });
    
    return _sharedManager;
    
}

+ (void)setSharedManager:(TGSocialManager *)sharedManager
{
    _sharedManager = sharedManager;
}

- (void)addSocialPlatform:(id<TGSocialPlatform>)platform
{
    if (!_socialPlatforms)
        _socialPlatforms = [[NSMutableArray alloc] init];
    
    [_socialPlatforms addObject:platform];
}

- (NSArray *)socialPlatforms
{
    return [_socialPlatforms copy];
}

- (void)fetchFriendsWithCompletion:(TGSocialManagerFriendsCompletionBlockType)completionBlock
{
    __block NSMutableArray *combinedFriends = [NSMutableArray array];
    
    __block int platformCount = 0;
    
    for(TGSocialPlatform *platform in _socialPlatforms)
    {
        [platform fetchFriendsWithCompletion:^(NSArray *friends, NSError *error) {
            [combinedFriends addObjectsFromArray:friends];
            
            platformCount++;
            
            if (platformCount == [_socialPlatforms count])
            {
                if (completionBlock)
                    completionBlock(combinedFriends, nil);
            }
        }];
    }
}

@end
