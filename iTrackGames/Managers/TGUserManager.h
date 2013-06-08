//
//  TGUserManager.h
//  iTrackGames
//
//  Created by Toni White on 3/3/13.
//  Copyright (c) 2013 Amanda Chappell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TGDataManager.h"

typedef void(^TGUserManagerCompletionBlockType)(NSError *error);

@interface TGUserManager : NSObject

@property (nonatomic, strong) TGDataManager *dataManager;

+(TGUserManager *) sharedManager;
+ (void)setSharedManager:(TGUserManager *)sharedManager;
-(void) loginWithUsername: (NSString *) username andPassword: (NSString *) password withCompletion: (TGUserManagerCompletionBlockType) completionBlock;
- (NSString *)currentUserToken;
- (void)setCurrentUserToken:(NSString *)token;
- (void)authenticateWithToken:(NSString *)token withCompletion: (TGUserManagerCompletionBlockType) completionBlock;
-(void) loginWithFacebookToken: (NSString *) fbToken withCompletion: (TGUserManagerCompletionBlockType) completionBlock;
@end
