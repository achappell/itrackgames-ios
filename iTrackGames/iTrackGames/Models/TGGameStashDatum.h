//
//  TGGameStashDatum.h
//  iTrackGames
//
//  Created by Amanda Chappell on 3/26/13.
//  Copyright (c) 2013 Amanda Chappell. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TGGameStashDatum : NSObject <NSCopying>

@property (nonatomic, copy) NSNumber *hasPlayed;
@property (nonatomic, copy) NSNumber *rating;

@end
