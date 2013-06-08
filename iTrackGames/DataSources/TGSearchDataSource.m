//
//  TGSearchDataSource.m
//  iTrackGames
//
//  Created by Amanda Chappell on 5/27/13.
//  Copyright (c) 2013 Amanda Chappell. All rights reserved.
//

#import "TGSearchDataSource.h"

@interface TGSearchDataSource()

@property (nonatomic, strong) NSString *searchTerm;

@end

@implementation TGSearchDataSource

- (void)fetchResultsForSearchTerm:(NSString *)searchTerm
{
    self.searchTerm = searchTerm;
    
    [self reloadData];
}

- (void) reloadData {
    [self startLoading];
    
    if (self.searchTerm)
    {
        [self.dataManager fetchSearchResultsWithSearchTerm:self.searchTerm withCompletion:^(id data, NSError *error) {
            
            if (!error)
            {
                self.searchResults = data;
            }
            
            [self endLoadingWithError:error];
        }];
    }
    else
    {
        [self endLoadingWithError:nil];
    }
}

@end
