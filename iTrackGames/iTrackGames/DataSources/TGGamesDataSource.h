//
//  TGGamesDataSource.h
//  iTrackGames
//
//  Created by Toni White on 3/24/13.
//  Copyright (c) 2013 Amanda Chappell. All rights reserved.
//

#import "TGViewDataSource.h"
#import "TGPlatform.h"

@interface TGGamesDataSource : TGViewDataSource
    @property (nonatomic, strong, readonly) NSArray *games;
    @property (nonatomic, strong, readwrite) TGPlatform *platform;

-(id)initWithPlatform:(TGPlatform *)platform;

@end
