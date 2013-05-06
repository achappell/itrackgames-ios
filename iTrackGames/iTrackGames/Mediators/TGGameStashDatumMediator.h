//
//  TGGameStashDatumMediator.h
//  iTrackGames
//
//  Created by Amanda Chappell on 5/5/13.
//  Copyright (c) 2013 Amanda Chappell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TGDataManager.h"

@interface TGGameStashDatumMediator : NSObject

@property (nonatomic, strong) TGDataManager *dataManager;

- (void)updateGame:(TGGame *)game withPlayStatus:(BOOL)status rating:(NSInteger)rating;

@end
