//
//  TGGames.h
//  iTrackGames
//
//  Created by Toni White on 2/17/13.
//  Copyright (c) 2013 Amanda Chappell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TGPlatform.h"
#import "TGGameStashDatum.h"

@interface TGGame : NSObject <NSCopying>

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *developer;
@property (nonatomic, copy) NSString *publisher;
@property (nonatomic, copy) NSString *overview;
@property (nonatomic, copy) NSNumber *game_id;
@property (nonatomic, copy) TGPlatform *platform;
@property (nonatomic, copy) TGGameStashDatum *gameStashDatum;

@end
