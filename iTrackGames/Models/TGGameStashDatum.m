//
//  TGGameStashDatum.m
//  iTrackGames
//
//  Created by Amanda Chappell on 3/26/13.
//  Copyright (c) 2013 Amanda Chappell. All rights reserved.
//

#import "TGGameStashDatum.h"
#import "TGGame.h"

@implementation TGGameStashDatum

-(id)copyWithZone:(NSZone *)zone
{
    TGGameStashDatum *copy = [[[self class] alloc] init];
    
    copy.hasPlayed = [self.hasPlayed copy];
    copy.rating = [self.rating copy];
    copy.game = [self.game copy];
    
    return copy;
}

@end
