//
//  TGImage.h
//  iTrackGames
//
//  Created by Toni White on 4/21/13.
//  Copyright (c) 2013 Amanda Chappell. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TGImage : NSObject <NSCopying>

@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *location;
@property (nonatomic, copy) NSNumber *image_id;

@end
