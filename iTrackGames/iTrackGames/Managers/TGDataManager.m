//
//  TGDataManager.m
//  iTrackGames
//
//  Created by Toni White on 3/3/13.
//  Copyright (c) 2013 Amanda Chappell. All rights reserved.
//

#import "TGDataManager.h"
#import <RestKit/RestKit.h>

@implementation TGDataManager

-(NSString *)fetchUserTokenWithUsername:(NSString *)username andPassword:(NSString *)password withCompletion:(TGDataManagerCompletionBlockType)completionBlock
{
    NSString *loginInfo = [NSString stringWithFormat:@"email=%@&password=%@", username, password];
    
    __block NSString *token;
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://icheckgames.herokuapp.com/tokens.json"]];
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
        
        if (completionBlock)
            completionBlock(nil, error);
    }];
    
    [loginOperation start];
    
    return token;
}
@end
