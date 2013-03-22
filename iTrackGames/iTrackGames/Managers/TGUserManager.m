//
//  TGUserManager.m
//  iTrackGames
//
//  Created by Toni White on 3/3/13.
//  Copyright (c) 2013 Amanda Chappell. All rights reserved.
//

#import <RestKit/RestKit.h>
#import "TGUserManager.h"
#import "TGUser.h"
#import "TGDataManager.h"
#import "TGUser.h"
#import "TGPlatformTableViewController.h"

@interface TGUserManager ()
    @property (nonatomic, strong) TGUser *currentUser;
@end

static TGUserManager *_sharedManager;

@implementation TGUserManager

+(TGUserManager *) sharedManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!_sharedManager)
        {
            _sharedManager = [[TGUserManager alloc] init];
        }
    });
    
    return _sharedManager;
    
}

+ (void)setSharedManager:(TGUserManager *)sharedManager
{
    _sharedManager = sharedManager;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.dataManager = [[TGDataManager alloc] init];
    }
    return self;
}

- (NSString *)currentUserToken
{
    return self.currentUser.token;
}

-(void) loginWithUsername: (NSString *) username andPassword: (NSString *) password withCompletion:(TGUserManagerCompletionBlockType) completionBlock
{
     [self.dataManager fetchUserTokenWithUsername:username andPassword:password withCompletion:^(id data, NSError *error) {
        NSLog(@"hell's yeah!");
        
        if (error == nil) {
            TGUser *currentUser = [[TGUser alloc] init];
            currentUser.token = (NSString *)data;
            
            self.currentUser = currentUser;
        }
         
         if (completionBlock)
             completionBlock(error);

    }];
    
}

@end
