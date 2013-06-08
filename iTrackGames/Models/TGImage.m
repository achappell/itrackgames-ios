//
//  TGImage.m
//  iTrackGames
//
//  Created by Toni White on 4/21/13.
//  Copyright (c) 2013 Amanda Chappell. All rights reserved.
//

#import "TGImage.h"

@implementation TGImage

-(id)copyWithZone:(NSZone *)zone
{
    TGImage *copy = [[[self class] alloc] init];
    
    copy.image_id = [self.image_id copy];
    copy.type = [self.type copy];
    copy.location = [self.location copy];
    
    return copy;
}

@end
