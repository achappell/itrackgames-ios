//
//  TGNavigationItemFactory.m
//  iTrackGames
//
//  Created by Amanda Chappell on 3/30/13.
//  Copyright (c) 2013 Amanda Chappell. All rights reserved.
//

#import "TGNavigationItemFactory.h"

static TGNavigationItemFactory *_sharedNavFactory;

@implementation TGNavigationItemFactory

/*
+ (void)setupDefaultNavigationItemsForViewController:(UIViewController<TGNavigationResponder> *)viewController
{
    if ([viewController respondsToSelector:@selector(navigationController)])
    {
        
        UIBarButtonItem *menuBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStylePlain target:viewController action:@selector(menuTapped)];
    
        [viewController.navigationItem setLeftBarButtonItem:menuBarButtonItem];
        
        UIBarButtonItem *searchBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:viewController action:@selector(searchTapped)];
        [viewController.navigationItem setRightBarButtonItem:searchBarButtonItem];
    }
}
*/

+(TGNavigationItemFactory *) sharedNavFactory
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!_sharedNavFactory)
        {
            _sharedNavFactory = [[TGNavigationItemFactory alloc] init];
        }
    });
    
    return _sharedNavFactory;
    
}

+ (void)setSharedNavFactory:(TGNavigationItemFactory *)sharedNavFactory
{
    _sharedNavFactory = sharedNavFactory;
}

- (UIBarButtonItem *) menuButton:(UIViewController<TGNavigationResponder> *)viewController
{
    return [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStylePlain target:viewController action:@selector(menuTapped)];
}

- (UIBarButtonItem *) searchButton:(UIViewController<TGNavigationResponder> *)viewController
{
    return [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:viewController action:@selector(searchTapped)];
}

@end
