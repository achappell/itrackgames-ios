//
//  TGGameStashDatumTests.m
//  iTrackGames
//
//  Created by Amanda Chappell on 3/27/13.
//  Copyright (c) 2013 Amanda Chappell. All rights reserved.
//

#import "TGGameStashDatumTests.h"

@interface TGGameStashDatumTests()
{
    TGGameStashDatum *gameStashDatum;
}

@end

@implementation TGGameStashDatumTests

- (void)setUp
{
    [super setUp];
    
    gameStashDatum = [TGGameStashDatumTests gameStashDatum];
}

+ (TGGameStashDatum *)gameStashDatum
{
    TGGameStashDatum *gameStashDatum = [[TGGameStashDatum alloc] init];
    
    gameStashDatum.hasPlayed = [NSNumber numberWithBool:YES];
    gameStashDatum.rating = [NSNumber numberWithInt:5];
    
    return gameStashDatum;
}

- (void)testThatCopyingGameStashDatumWorks
{
    TGGameStashDatum *copy = [gameStashDatum copy];
    
    STAssertEqualObjects(gameStashDatum.hasPlayed, copy.hasPlayed, @"HasPlayed wasn't copied");
    STAssertEqualObjects(gameStashDatum.rating, copy.rating, @"Rating wasn't copied");
}

@end
