//
//  TGPlatformDataSource.h
//  iTrackGames
//
//  Created by Toni White on 4/21/13.
//  Copyright (c) 2013 Amanda Chappell. All rights reserved.
//

#import "TGViewDataSource.h"

@interface TGPlatformDataSource : TGViewDataSource
    @property (nonatomic, strong) TGPlatform *platform;
    @property (nonatomic, strong) NSNumber *platformId;

    -(id)initWithPlatformId:(NSNumber *)platformId;
@end
