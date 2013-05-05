//
//  TGGameDataSource.m
//  iTrackGames
//
//  Created by Toni White on 3/30/13.
//  Copyright (c) 2013 Amanda Chappell. All rights reserved.
//

#import "TGGameDataSource.h"
#import "TGDataManager.h"

@implementation TGGameDataSource

-(id)initWithGameId:(NSNumber *)gameId
{
    self = [super init];
    if (self)
    {
        self.gameId = gameId;
    }
    
    return self;
}

- (void) reloadData {
    [self startLoading];
    
    [self.dataManager fetchGameData: self.gameId withCompletion:^(id data, NSError *error) {
        
        if (!error)
        {
            self.game = data;
        }
        
        [self endLoadingWithError:error];
    }];
}

@end