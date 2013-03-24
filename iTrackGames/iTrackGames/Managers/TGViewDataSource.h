//
//  TGViewDataSource.h
//  iTrackGames
//
//  Created by Amanda Chappell on 3/24/13.
//  Copyright (c) 2013 Amanda Chappell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TGDataManager.h"

@protocol TGViewDataSourceDelegate;

@protocol TGViewDataSource <NSObject>

@property (nonatomic, weak) id<TGViewDataSourceDelegate> delegate;
@property (nonatomic, readonly) BOOL isLoading;

- (void)setNeedsDataReload;
- (void)reloadDataIfNeeded;
- (void)startLoading;
- (void)endLoadingWithError:(NSError *)error;

@end

@protocol TGViewDataSourceDelegate <NSObject>

@optional

- (void)viewDataSourceDidBeginLoading:(id<TGViewDataSource>)dataSource;
- (void)viewDataSourceDidEndLoading:(id<TGViewDataSource>)dataSource;
- (void)viewDataSourceDidUpdateContent:(id<TGViewDataSource>)dataSource;
- (void)viewDataSource:(id<TGViewDataSource>)dataSource didFailWithError:(NSError *)error;

@end

@interface TGViewDataSource : NSObject <TGViewDataSource>

@property (nonatomic, readonly) BOOL isLoading;
@property (nonatomic, weak) id delegate;
@property (nonatomic, strong) TGDataManager *dataManager;

@end
