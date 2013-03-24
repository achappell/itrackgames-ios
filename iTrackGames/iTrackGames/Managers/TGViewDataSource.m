//
//  TGViewDataSource.m
//  iTrackGames
//
//  Created by Amanda Chappell on 3/24/13.
//  Copyright (c) 2013 Amanda Chappell. All rights reserved.
//

#import "TGViewDataSource.h"

@interface TGViewDataSource ()
{
	struct
	{
		unsigned int delegateViewDataSourceDidBeginLoading : 1;
		unsigned int delegateViewDataSourceDidEndLoading : 1;
		unsigned int delegateViewDataSourceDidUpdateContent : 1;
		unsigned int delegateViewDataSourceDidFailWithError : 1;
	} _delegateFlags;
	
	BOOL _needsReload;
}

@property (nonatomic, assign) BOOL isLoading;

@end

@implementation TGViewDataSource

- (id)init
{
    self = [super init];
    if (self)
    {
        self.dataManager = [[TGDataManager alloc] init];
        [self setNeedsDataReload];
    }
    return self;
}

- (void)startLoading
{
    self.isLoading = YES;
}

- (void)endLoadingWithError:(NSError *)error
{
    self.isLoading = NO;
    
    if (error)
        [self notifyDelegateOfFailureWithError:error];
    else
        [self contentDidUpdate];
}

#pragma mark - Setters

- (void)setDelegate:(id<TGViewDataSourceDelegate>)delegate
{
	_delegate = delegate;
	
	_delegateFlags.delegateViewDataSourceDidBeginLoading = [delegate respondsToSelector:@selector(viewDataSourceDidBeginLoading:)];
	_delegateFlags.delegateViewDataSourceDidEndLoading = [delegate respondsToSelector:@selector(viewDataSourceDidEndLoading:)];
	_delegateFlags.delegateViewDataSourceDidFailWithError = [delegate respondsToSelector:@selector(viewDataSource:didFailWithError:)];
	_delegateFlags.delegateViewDataSourceDidUpdateContent = [delegate respondsToSelector:@selector(viewDataSourceDidUpdateContent:)];
}

- (void)setIsLoading:(BOOL)isLoading
{
	if (_isLoading == isLoading)
		return;
	
	_isLoading = isLoading;
	
	if (isLoading && _delegateFlags.delegateViewDataSourceDidBeginLoading)
		[self.delegate viewDataSourceDidBeginLoading:self];
	
	else if (!isLoading && _delegateFlags.delegateViewDataSourceDidEndLoading)
		[self.delegate viewDataSourceDidEndLoading:self];
}

#pragma mark - Protected

- (void)contentDidUpdate
{
	if (_delegateFlags.delegateViewDataSourceDidUpdateContent)
		[self.delegate viewDataSourceDidUpdateContent:self];
}

#pragma mark - Private

- (void)notifyDelegateOfFailureWithError:(NSError *)error
{
	if (_delegateFlags.delegateViewDataSourceDidFailWithError)
		[self.delegate viewDataSource:self didFailWithError:error];
}

#pragma mark - Data Reloading

- (void)setNeedsDataReload
{
	_needsReload = YES;
}

- (void)reloadDataIfNeeded
{
	if (!_needsReload)
		return;
	
	_needsReload = NO;
	[self reloadData];
}

- (void)reloadData
{
	// Subclasses should implement this method
    NSAssert(YES, @"Subclass should implement");
}

@end
