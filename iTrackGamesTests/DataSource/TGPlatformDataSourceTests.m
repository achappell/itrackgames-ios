//
//  TGPlatformDataSourceTests.m
//  iTrackGames
//
//  Created by Toni White on 6/8/13.
//  Copyright (c) 2013 Amanda Chappell. All rights reserved.
//

#import "TGPlatformDataSourceTests.h"
#import "TGPlatformDataSource.h"
#import <OCMock/OCMock.h>
#import "TGPlatformViewController.h"

@implementation TGPlatformDataSourceTests

-(void) testThatPlatformLoadsData
{
    id mockDataManager = [OCMockObject mockForClass: [TGDataManager class]];
    
    [[[mockDataManager stub] andDo:^(NSInvocation *invocation) {
        void (^completionBlock)(id data, NSError *error) = nil;
        [invocation getArgument:&completionBlock atIndex:3];
        
        NSError *error = nil;
        
        completionBlock(@[ @{@"id": @"1", @"name": @"3DO", @"overview": @"The 3DO Interactive Multiplayer (often called simply 3DO) is a video game console originally produced by Panasonic in 1993. Further renditions of the hardware were released in 1994 by Sanyo and Goldstar. The consoles were manufactured according to specifications created by The 3DO Company, and were originally designed by Dave Needle and RJ Mical of New Technology Group. The system was conceived by entrepreneur and Electronic Arts founder Trip Hawkins. Despite a highly promoted launch (including being named Time magazine&#039;s &quot;1994 Product of the Year&quot;) and a host of cutting-edge technologies, the 3DO&#039;s high price (US$699.95 at launch), limited third-party developer support, and an over-saturated console market prevented the system from achieving success comparable to competitors Sega and Nintendo. This console was released in North America on October 4, 1993, Japan on March 20, 1994 and in Europe in 1994.", @"developer": @"The 3DO Company", @"rating": @"8",@"images": @[ @{@"id": @"16215",@"location": @"http://thegamesdb.net/banners/platform/boxart/25-1.jpg", @"type": @"boxart"} ]}], error);
    }] fetchPlatformData:[OCMArg any] withCompletion: [OCMArg any]];
    
    id delegate = [OCMockObject mockForClass: [TGPlatformViewController class]];
    [[delegate expect] viewDataSourceDidUpdateContent: [OCMArg any]];
    
    TGPlatformDataSource *dataSource = [[TGPlatformDataSource alloc] initWithPlatformId:@1];
    dataSource.dataManager = mockDataManager;
    dataSource.delegate = delegate;
    [dataSource reloadDataIfNeeded];
    
    STAssertNotNil(dataSource.platform, @"Platform was not populated");
    [delegate verify];
}

@end
