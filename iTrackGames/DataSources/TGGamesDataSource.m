//
//  TGGamesDataSource.m
//  iTrackGames
//
//  Created by Toni White on 3/24/13.
//  Copyright (c) 2013 Amanda Chappell. All rights reserved.
//

#import "TGGamesDataSource.h"
#import "TGDataManager.h"

@interface TGGamesDataSource()

@property (nonatomic, strong, readwrite) NSArray *games;

@end

@implementation TGGamesDataSource

-(id)initWithPlatform:(TGPlatform *)platform
{
    self = [super init];
    if (self)
    {
        self.platform = platform;
    }
    
    return self;
}

- (void) reloadData {
    [self startLoading];
    
    [self.dataManager fetchGamesWithPlatform: self.platform withCompletion:^(id data, NSError *error) {
        
        if (!error)
        {
            NSMutableArray *games = [NSMutableArray arrayWithArray:(NSArray *)data];
            [games sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES]]];
            self.games = games;
        }
        
        [self endLoadingWithError:error];
    }];
}

@end
