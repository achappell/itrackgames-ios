//
//  TGDataMangerTests.m
//  iTrackGames
//
//  Created by Amanda Chappell on 3/21/13.
//  Copyright (c) 2013 Amanda Chappell. All rights reserved.
//

#import "TGUserMangerTests.h"
#import "TGUserManager.h"
#import <OCMock/OCMock.h>
#import "TGLoginViewController.h"

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
    id mockUserManager = [OCMockObject mockForClass:[TGUserManager class]];
 
    [[[mockUserManager stub] andDo:^(NSInvocation *invocation) {
        
        void (^completionBlock)(NSError *error) = nil;
        [invocation getArgument:&completionBlock atIndex:4];
        
        NSError *error = nil;
        
        completionBlock(error);
        
    }] loginWithUsername:@"achappell@me.com" andPassword:@"test123" withCompletion:[OCMArg any]];
    
    TGLoginViewController *loginViewController = [[TGLoginViewController alloc] init];
    
    loginViewController.username = @"achappell@me.com";
    loginViewController.password = @"test123";

    [TGUserManager sharedManager];
    [TGUserManager setSharedManager:mockUserManager];
    
    [loginViewController loginUser];
    
    STAssertNotNil([TGUserManager sharedManager].currentUserToken, @"No Current User Token");
}

@end
