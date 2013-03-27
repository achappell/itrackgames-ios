//
//  TGGameTests.m
//  iTrackGames
//
//  Created by Amanda Chappell on 3/22/13.
//  Copyright (c) 2013 Amanda Chappell. All rights reserved.
//

#import "TGGameTests.h"
#import "TGGame.h"
#import "TGPlatformTests.h"
#import "TGGameStashDatumTests.h"

@interface TGGameTests()
{
    TGGame *game;
}

@end

@implementation TGGameTests

- (void)setUp
{
    [super setUp];
    
    game = [TGGameTests game];
}

+ (TGGame *)game
{
    TGGame *game = [[TGGame alloc] init];
    
    game.title = @"Assassin's Creed";
    game.developer = @"UBISoft";
    game.publisher = @"UBISoft";
    game.overview = @"Great Game";
    game.game_id = [NSNumber numberWithInt:1];
    game.platform = [TGPlatformTests platform];
    game.gameStashDatum = [TGGameStashDatumTests gameStashDatum];
    
    return game;
}

- (void)testThatCopyingGameWorks
{
    TGGame *copy = [game copy];
    
    STAssertEqualObjects(game.title, copy.title, @"Developer wasn't copied");
    STAssertEqualObjects(game.developer, copy.developer, @"Platform Id wasn't copied");
    STAssertEqualObjects(game.publisher, copy.publisher, @"Name wasn't copied");
    STAssertEqualObjects(game.overview, copy.overview, @"Overview wasn't copied");
    STAssertEqualObjects(game.game_id, copy.game_id, @"Rating wasn't copied");
    
    // platform
    STAssertEqualObjects(game.platform.developer, copy.platform.developer, @"Platform Developer wasn't copied");
    STAssertEqualObjects(game.platform.platform_id, copy.platform.platform_id, @"Platform Id wasn't copied");
    STAssertEqualObjects(game.platform.name, copy.platform.name, @"Platform Name wasn't copied");
    STAssertEqualObjects(game.platform.overview, copy.platform.overview, @"Platform Overview wasn't copied");
    STAssertEqualObjects(game.platform.rating, copy.platform.rating, @"Platform Rating wasn't copied");
    
    // game stash datum
    STAssertEqualObjects(game.gameStashDatum.hasPlayed, copy.gameStashDatum.hasPlayed, @"HasPlayed wasn't copied");
    STAssertEqualObjects(game.gameStashDatum.rating, copy.gameStashDatum.rating, @"Rating wasn't copied");
}

- (void)testThatDescriptionIsCorrect
{
    NSString *description = [game description];
    
    STAssertEquals(description, @"Assassin's Creed", @"Description doesn't match name");
}


@end
