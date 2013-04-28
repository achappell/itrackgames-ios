//
//  TGDataManager.m
//  iTrackGames
//
//  Created by Toni White on 3/3/13.
//  Copyright (c) 2013 Amanda Chappell. All rights reserved.
//

#import "TGDataManager.h"
#import <RestKit/RestKit.h>
#import "TGConstants.h"
#import "TGUserManager.h"
#import "TGGame.h"
#import "TGPlatform.h"

@implementation TGDataManager

-(void)fetchUserTokenWithUsername:(NSString *)username andPassword:(NSString *)password withCompletion:(TGDataManagerCompletionBlockType)completionBlock
{
    NSString *loginInfo = [NSString stringWithFormat:@"email=%@&password=%@", username, password];
    
    __block NSString *token;
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://itrackgames.com/tokens.json"]];
    request.HTTPMethod = @"POST";
    [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:[loginInfo dataUsingEncoding:NSUTF8StringEncoding]];
    
    AFJSONRequestOperation *loginOperation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSLog(@"success %@", JSON);
        
        if (completionBlock)
            completionBlock(JSON, nil);
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"failure %@", [error description]);
        
        token = nil;
        
        NSError *appError = error;
        
        // unauthorized
        if (response.statusCode == 401)
        {
            appError = [NSError errorWithDomain:TGUserErrorDomain code:TGUserInvalidUsernamePasswordError userInfo:@{NSLocalizedDescriptionKey: @"Your username or password is invalid"}];
        }
        else
        {
            appError = [NSError errorWithDomain:TGUserErrorDomain code:TGUserUnknownLoginError userInfo:@{NSLocalizedDescriptionKey: @"Uh oh, something has gon awry. Check back later."}];
        }
        
        if (completionBlock)
            completionBlock(nil, appError);
    }];
    
    [loginOperation start];
}

- (void)fetchPlatformsWithCompletion:(TGDataManagerCompletionBlockType)completionBlock
{
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    
    NSString *userToken = [TGUserManager sharedManager].currentUserToken;
    
    NSDictionary *parameters = nil;
    
    if (userToken != nil) {
        parameters = @{@"auth_token": userToken};
    }
    
    [objectManager getObjectsAtPath:@"/platforms.json" parameters:parameters success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        
        NSArray *platforms = [mappingResult array];
        
        if (completionBlock)
            completionBlock(platforms, nil);
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        
        if (completionBlock)
            completionBlock(nil, error);
        
    }];
}

-(void) fetchGamesWithPlatform:(TGPlatform *)platform withCompletion: (TGDataManagerCompletionBlockType)completionBlock
{
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    
    NSString *userToken = [TGUserManager sharedManager].currentUserToken;
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{@"platform_id": platform.platform_id}];
    
    if (userToken != nil) {
        [parameters setObject:userToken forKey:@"auth_token"];
    }
    
    [objectManager getObjectsAtPath:@"/games.json" parameters:parameters success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        
        NSArray *games = [mappingResult array];
        
        if (completionBlock)
            completionBlock(games, nil);
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        
        if (completionBlock)
            completionBlock(nil, error);
        
    }];
}

-(void) fetchGameData: (NSNumber *)gameId withCompletion: (TGDataManagerCompletionBlockType) completionBlock
{
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    
    NSString *path = [NSString stringWithFormat:@"/games/%i.json",[gameId intValue]];
    
    [objectManager getObjectsAtPath:path parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        
        TGGame *game = [mappingResult firstObject];
        
        if (completionBlock)
            completionBlock(game, nil);
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        if (completionBlock)
            completionBlock(nil, error);
    }];
}

-(void) fetchPlatformData:(NSNumber *)platformId withCompletion:(TGDataManagerCompletionBlockType)completionBlock
{
    
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    
    NSString *path = [NSString stringWithFormat:@"/platforms/%i.json",[platformId intValue]];
    
    [objectManager getObjectsAtPath:path parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        
        TGPlatform *platform = [mappingResult firstObject];
        
        if (completionBlock)
            completionBlock(platform, nil);
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        if (completionBlock)
            completionBlock(nil, error);
    }];
}

@end