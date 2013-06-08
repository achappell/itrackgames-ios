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
#import "TGConstants.h"

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

- (void)setCurrentUserToken:(NSString *)token
{
    self.currentUser.token = token;
}

-(void) loginWithUsername: (NSString *) username andPassword: (NSString *) password withCompletion:(TGUserManagerCompletionBlockType) completionBlock
{
    if ([username isEqualToString:@""] || [password isEqualToString:@""])
    {
        NSError *error = [NSError errorWithDomain:TGUserErrorDomain code:TGUserInvalidUsernamePasswordError userInfo:@{NSLocalizedDescriptionKey: @"Your username or password is invalid"}];
        
        if (completionBlock)
            completionBlock(error);
    }
    else
    {
        [self.dataManager fetchUserTokenWithUsername:username andPassword:password withCompletion:^(id data, NSError *error) {
            
            if (!error) {
                NSString *token = (NSString *)[data objectForKey:@"token"];
                
                TGUser *currentUser = [[TGUser alloc] init];
                currentUser.token = token;
                
                self.currentUser = currentUser;
                
                //store token in NSUserDefaults to save login info
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:token forKey:@"userLoginToken"];
            }
            
            if (completionBlock)
                completionBlock(error);

        }];
    }
}

- (void)authenticateWithToken:(NSString *)token withCompletion:(TGUserManagerCompletionBlockType)completionBlock
{
   
    [self.dataManager validateToken:(NSString *) token withCompletion:^(id data, NSError *error) {
        
        if (!error) {
            TGUser *currentUser = [[TGUser alloc] init];
            self.currentUser = currentUser;
            self.currentUser.token = token;
        } else {
            self.currentUser = nil;
        }
        
        if (completionBlock)
            completionBlock(error);
        
    }];
}

-(void) loginWithFacebookToken:(NSString *)fbToken withCompletion:(TGUserManagerCompletionBlockType)completionBlock
{

    [self.dataManager fetchUserTokenWithFacebookToken:fbToken withCompletion:^(id data, NSError *error) {
        
        if (!error) {
            NSString *token = (NSString *)[data objectForKey:@"token"];
            
            TGUser *currentUser = [[TGUser alloc] init];
            currentUser.token = token;
            
            self.currentUser = currentUser;
            
            //store token in NSUserDefaults to save login info
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:token forKey:@"userLoginToken"];
        }
        
        if (completionBlock)
            completionBlock(error);
        
    }];
}

@end
