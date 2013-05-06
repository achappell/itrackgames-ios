//
//  TGGameStashDatumMediator.m
//  iTrackGames
//
//  Created by Amanda Chappell on 5/5/13.
//  Copyright (c) 2013 Amanda Chappell. All rights reserved.
//

#import "TGGameStashDatumMediator.h"

@implementation TGGameStashDatumMediator

- (id)init
{
    self = [super init];
    if (self)
    {
        self.dataManager = [[TGDataManager alloc] init];
    }
    return self;
}

- (void)updateGame:(TGGame *)game withPlayStatus:(BOOL)status rating:(NSInteger)rating
{
    game.gameStashDatum.hasPlayed = [NSNumber numberWithBool:status];
    game.gameStashDatum.rating = [NSNumber numberWithInt:rating + 1];
#warning Maybe there is a better way to do this?
    game.gameStashDatum.game = game;
    
    [self.dataManager postGameStashDatum:game.gameStashDatum withCompletion:^(id data, NSError *error) {
        if (!error)
            NSLog( @"success!");
    }];
}

@end
