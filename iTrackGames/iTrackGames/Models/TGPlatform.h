//
//  TGPlatform.h
//  iTrackGames
//
//  Created by Toni White on 2/17/13.
//  Copyright (c) 2013 Amanda Chappell. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TGPlatform : NSObject <NSCopying>

@property (nonatomic, copy) NSString *developer;
@property (nonatomic, copy) NSNumber *platform_id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *overview;
@property (nonatomic, copy) NSString *rating;

@end
