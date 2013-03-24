//
//  TGPlatformsDataSource.m
//  iTrackGames
//
//  Created by Amanda Chappell on 3/24/13.
//  Copyright (c) 2013 Amanda Chappell. All rights reserved.
//

#import "TGPlatformsDataSource.h"
#import "TGDataManager.h"

@interface TGPlatformsDataSource()

@property (nonatomic, strong, readwrite) NSArray *platforms;

@end

@implementation TGPlatformsDataSource

- (void)reloadData
{
    [self startLoading];
    
    [self.dataManager fetchPlatformsWithCompletion:^(id data, NSError *error) {
        
        if (!error)
            self.platforms = (NSArray *)data;
        
        [self endLoadingWithError:error];
     
    }];
}

@end
