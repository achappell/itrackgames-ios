//
//  TGGames.m
//  iTrackGames
//
//  Created by Toni White on 2/17/13.
//  Copyright (c) 2013 Amanda Chappell. All rights reserved.
//

#import "TGGame.h"

@implementation TGGame

-(NSString *)description
{
    return self.title;
}

-(id)copyWithZone:(NSZone *)zone
{
    TGGame *copy = [[[self class] alloc] init];
    
    copy.title = [self.title copy];
    copy.developer = [self.developer copy];
    copy.publisher = [self.publisher copy];
    copy.overview = [self.overview copy];
    copy.game_id = [self.game_id copy];
    
    return copy;
}

@end
