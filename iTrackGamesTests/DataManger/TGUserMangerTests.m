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
#import "TGConstants.h"

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

- (void)testThatMocksEmptyUserLoginParameters
{
    id mockDataManager = [OCMockObject mockForClass:[TGDataManager class]];
    
    [[mockDataManager reject] fetchUserTokenWithUsername:[OCMArg any] andPassword:[OCMArg any] withCompletion:[OCMArg any]];
    
    TGUserManager *userManager = [[TGUserManager alloc] init];
    
    [TGUserManager sharedManager];
    [TGUserManager setSharedManager:userManager];
    
    userManager.dataManager = mockDataManager;
    
    [[TGUserManager sharedManager] loginWithUsername:@"" andPassword:@"" withCompletion:^(NSError *error) {
        
        STAssertNotNil(error, @"No Error Returned");
        STAssertEquals(error.code, TGUserInvalidUsernamePasswordError, @"Wrong error code");
        [mockDataManager verify];
    }];
}

- (void)testThatMocksUnauthorizedLogin
{
    id mockDataManager = [OCMockObject mockForClass:[TGDataManager class]];
    
    [[[mockDataManager stub] andDo:^(NSInvocation *invocation) {
        
        void (^completionBlock)(id data, NSError *error) = nil;
        [invocation getArgument:&completionBlock atIndex:4];
        
        NSError *error = [NSError errorWithDomain:TGUserErrorDomain code:TGUserInvalidUsernamePasswordError userInfo:@{NSLocalizedDescriptionKey: @"Your username or password is invalid"}];
        
        completionBlock(nil, error);
        
    }] fetchUserTokenWithUsername:[OCMArg any] andPassword:[OCMArg any] withCompletion:[OCMArg any]];
    
    TGUserManager *userManager = [[TGUserManager alloc] init];
    
    [TGUserManager sharedManager];
    [TGUserManager setSharedManager:userManager];
    
    userManager.dataManager = mockDataManager;
    
    [[TGUserManager sharedManager] loginWithUsername:@"badUser" andPassword:@"badPass" withCompletion:^(NSError *error) {
        
        STAssertNotNil(error, @"No Error Returned");
        STAssertEquals(error.code, TGUserInvalidUsernamePasswordError, @"Wrong error code");
        
    }];
}

- (void)testThatMocksUnknownLoginError
{
    id mockDataManager = [OCMockObject mockForClass:[TGDataManager class]];
    
    [[[mockDataManager stub] andDo:^(NSInvocation *invocation) {
        
        void (^completionBlock)(id data, NSError *error) = nil;
        [invocation getArgument:&completionBlock atIndex:4];
        
        NSError *error = [NSError errorWithDomain:TGUserErrorDomain code:TGUserUnknownLoginError userInfo:@{NSLocalizedDescriptionKey: @"Uh oh, something has gon awry. Check back later."}];
        
        completionBlock(nil, error);
        
    }] fetchUserTokenWithUsername:[OCMArg any] andPassword:[OCMArg any] withCompletion:[OCMArg any]];
    
    TGUserManager *userManager = [[TGUserManager alloc] init];
    
    [TGUserManager sharedManager];
    [TGUserManager setSharedManager:userManager];
    
    userManager.dataManager = mockDataManager;
    
    [[TGUserManager sharedManager] loginWithUsername:@"badUser" andPassword:@"badPass" withCompletion:^(NSError *error) {
        
        STAssertNotNil(error, @"No Error Returned");
        STAssertEquals(error.code, TGUserUnknownLoginError, @"Wrong error code");
        
    }];
}

@end
