//
//  TGNavigationItemFactory.h
//  iTrackGames
//
//  Created by Amanda Chappell on 3/30/13.
//  Copyright (c) 2013 Amanda Chappell. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TGNavigationResponder <NSObject>

@required
- (void)searchTapped;
- (void)menuTapped;

@end

@interface TGNavigationItemFactory : NSObject

//+ (void)setupDefaultNavigationItemsForViewController:(UIViewController<TGNavigationResponder> *)viewController;

+(TGNavigationItemFactory *) sharedNavFactory;
+ (void)setSharedNavFactory:(TGNavigationItemFactory *)sharedNavFactory;

- (UIBarButtonItem *) menuButton:(UIViewController<TGNavigationResponder> *)viewController;
- (UIBarButtonItem *) searchButton:(UIViewController<TGNavigationResponder> *)viewController;
@end
