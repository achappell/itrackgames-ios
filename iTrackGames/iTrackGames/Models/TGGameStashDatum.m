//
//  TGGameStashDatum.m
//  iTrackGames
//
//  Created by Amanda Chappell on 3/26/13.
//  Copyright (c) 2013 Amanda Chappell. All rights reserved.
//

#import "TGGameStashDatum.h"

@implementation TGGameStashDatum

-(id)copyWithZone:(NSZone *)zone
{
    TGGameStashDatum *copy = [[[self class] alloc] init];
    
    copy.hasPlayed = [self.hasPlayed copy];
    copy.rating = [self.rating copy];
    
    return copy;
}

@end
