//
//  TGGameDataSource.h
//  iTrackGames
//
//  Created by Toni White on 3/30/13.
//  Copyright (c) 2013 Amanda Chappell. All rights reserved.
//

#import "TGViewDataSource.h"
#import "TGGame.h"

@interface TGGameDataSource : TGViewDataSource
    @property (nonatomic, strong) TGGame *game;
    @property (nonatomic, strong) NSNumber *gameId;

    -(id)initWithGameId:(NSNumber *)gameId;
@end
