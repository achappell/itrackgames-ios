//
//  TGSearchDataSource.h
//  iTrackGames
//
//  Created by Amanda Chappell on 5/27/13.
//  Copyright (c) 2013 Amanda Chappell. All rights reserved.
//

#import "TGViewDataSource.h"

@interface TGSearchDataSource : TGViewDataSource

@property (nonatomic, strong) NSArray *searchResults;

- (void)fetchResultsForSearchTerm:(NSString *)searchTerm;

@end
