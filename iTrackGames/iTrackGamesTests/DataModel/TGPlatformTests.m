//
//  TGPlatformTests.m
//  iTrackGames
//
//  Created by Amanda Chappell on 3/21/13.
//  Copyright (c) 2013 Amanda Chappell. All rights reserved.
//

#import "TGPlatformTests.h"
#import "TGPlatform.h"

@interface TGPlatformTests()
{
    TGPlatform *platform;
}

@end

@implementation TGPlatformTests

- (void)setUp
{
    [super setUp];
    
    platform = [TGPlatformTests platform];
}

+ (TGPlatform *)platform
{
    TGPlatform *platform = [[TGPlatform alloc] init];
    
    platform.developer = @"Microsoft";
    platform.platform_id = [NSNumber numberWithInt:1];
    platform.name = @"XBOX";
    platform.overview = @"Great Platform";
    platform.rating = @"5";
    
    return platform;
}

- (void)testThatCopyingPlatformWorks
{
    TGPlatform *copy = [platform copy];
    
    STAssertEqualObjects(platform.developer, copy.developer, @"Developer wasn't copied");
    STAssertEqualObjects(platform.platform_id, copy.platform_id, @"Platform Id wasn't copied");
    STAssertEqualObjects(platform.name, copy.name, @"Name wasn't copied");
    STAssertEqualObjects(platform.overview, copy.overview, @"Overview wasn't copied");
    STAssertEqualObjects(platform.rating, copy.rating, @"Rating wasn't copied");
}

- (void)testThatDescriptionIsCorrect
{
    NSString *description = [platform description];
    
    STAssertEquals(description, @"XBOX", @"Description doesn't match name");
}

@end
