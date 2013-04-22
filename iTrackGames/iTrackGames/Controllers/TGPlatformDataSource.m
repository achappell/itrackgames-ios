//
//  TGPlatformDataSource.m
//  iTrackGames
//
//  Created by Toni White on 4/21/13.
//  Copyright (c) 2013 Amanda Chappell. All rights reserved.
//

#import "TGPlatformDataSource.h"

@implementation TGPlatformDataSource

-(id)initWithPlatformId:(NSNumber *)platformId
{
    self = [super init];
    if (self)
    {
        self.platformId = platformId;
    }
    
    return self;
}

- (void) reloadData {
    /*[self startLoading];
    
    [self.dataManager fetchGameData: self.gameId withCompletion:^(id data, NSError *error) {
        
        if (!error)
        {
            self.game = data;
        }
        
        [self endLoadingWithError:error];
    }];*/
}

@end
