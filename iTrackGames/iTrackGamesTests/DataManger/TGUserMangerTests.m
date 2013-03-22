//
//  TGDataMangerTests.m
//  iTrackGames
//
//  Created by Amanda Chappell on 3/21/13.
//  Copyright (c) 2013 Amanda Chappell. All rights reserved.
//

#import "TGUserMangerTests.h"
#import "TGUserManager.h"
#import "TGDataManager.h"
#import <OCMock/OCMock.h>

@implementation TGUserManagerTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testThatMocksUserLogin
{
    id mockDataManager = [OCMockObject mockForClass:[TGDataManager class]];
 
    [[[mockDataManager stub] andDo:^(NSInvocation *invocation) {
        
        void (^completionBlock)(id data, NSError *error) = nil;
        [invocation getArgument:&completionBlock atIndex:4];
        
        NSError *error = nil;
        
        completionBlock(@{@"token": @"sdfoiwe40823"}, error);
        
    }] fetchUserTokenWithUsername:[OCMArg any] andPassword:[OCMArg any] withCompletion:[OCMArg any]];
    
    TGUserManager *userManager = [[TGUserManager alloc] init];
    
    [TGUserManager sharedManager];
    [TGUserManager setSharedManager:userManager];
    
    userManager.dataManager = mockDataManager;
    
    [[TGUserManager sharedManager] loginWithUsername:@"achappell@me.com" andPassword:@"testtest" withCompletion:^(NSError *error) {
        
        STAssertNotNil([TGUserManager sharedManager].currentUserToken, @"No Current User Token");
        STAssertEquals([TGUserManager sharedManager].currentUserToken, @"sdfoiwe40823", @"Current User Token doesn't match");
        
    }];
}

@end
