//
//  TGPlatform.m
//  iTrackGames
//
//  Created by Toni White on 2/17/13.
//  Copyright (c) 2013 Amanda Chappell. All rights reserved.
//

#import "TGPlatform.h"
#import "TGGame.h"

@implementation TGPlatform

-(NSString *)description
{
    return self.name;
}

-(id)copyWithZone:(NSZone *)zone
{
    TGPlatform *copy = [[[self class] alloc] init];
    
    copy.developer = [self.developer copy];
    copy.platform_id = [self.platform_id copy];
    copy.name = [self.name copy];
    copy.overview = [self.overview copy];
    copy.rating = [self.rating copy];
    copy.games = [self.games copy];
    
    return copy;
}

@end
