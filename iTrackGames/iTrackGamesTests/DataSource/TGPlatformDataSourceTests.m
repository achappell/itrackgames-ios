//
//  TGPlatformDataSourceTests.m
//  iTrackGames
//
//  Created by Amanda Chappell on 3/24/13.
//  Copyright (c) 2013 Amanda Chappell. All rights reserved.
//

#import "TGPlatformDataSourceTests.h"
#import "TGPlatformsDataSource.h"
#import <OCMock/OCMock.h>

@implementation TGPlatformDataSourceTests

- (void)testThatPlatformReloadsData
{
    id mockDataManager = [OCMockObject mockForClass:[TGDataManager class]];
    
    [[[mockDataManager stub] andDo:^(NSInvocation *invocation) {
        
        void (^completionBlock)(id data, NSError *error) = nil;
        [invocation getArgument:&completionBlock atIndex:2];
        
        NSError *error = nil;
        
        completionBlock(@[ @{@"id": @"1", @"name": @"3DO"} ], error);
        
    }] fetchPlatformsWithCompletion:[OCMArg any]];
    
    TGPlatformsDataSource *dataSource = [[TGPlatformsDataSource alloc] init];
    dataSource.dataManager = mockDataManager;
    [dataSource reloadDataIfNeeded];
    
    STAssertNotNil(dataSource.platforms, @"Platforms was populated");
}

@end
