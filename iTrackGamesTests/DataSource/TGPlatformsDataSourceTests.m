//
//  TGPlatformDataSourceTests.m
//  iTrackGames
//
//  Created by Amanda Chappell on 3/24/13.
//  Copyright (c) 2013 Amanda Chappell. All rights reserved.
//

#import "TGPlatformsDataSourceTests.h"
#import "TGPlatformsDataSource.h"
#import <OCMock/OCMock.h>
#import "TGPlatformTableViewController.h"

@implementation TGPlatformsDataSourceTests

- (void)testThatPlatformReloadsData
{
    id mockDataManager = [OCMockObject mockForClass:[TGDataManager class]];
    
    [[[mockDataManager stub] andDo:^(NSInvocation *invocation) {
        
        void (^completionBlock)(id data, NSError *error) = nil;
        [invocation getArgument:&completionBlock atIndex:2];
        
        NSError *error = nil;
        
        completionBlock(@[ @{@"id": @"1", @"name": @"3DO"} ], error);
        
    }] fetchPlatformsWithCompletion:[OCMArg any]];
    
    id delegate = [OCMockObject mockForClass:[TGPlatformTableViewController class]];
    [[delegate expect] viewDataSourceDidUpdateContent:[OCMArg any]];
    
    TGPlatformsDataSource *dataSource = [[TGPlatformsDataSource alloc] init];
    dataSource.dataManager = mockDataManager;
    dataSource.delegate = delegate;
    [dataSource reloadDataIfNeeded];
    
    STAssertNotNil(dataSource.platforms, @"Platforms was populated");
    [delegate verify];
}

@end
