//
//  TGNavigationItemFactory.m
//  iTrackGames
//
//  Created by Amanda Chappell on 3/30/13.
//  Copyright (c) 2013 Amanda Chappell. All rights reserved.
//

#import "TGNavigationItemFactory.h"

@implementation TGNavigationItemFactory

+ (void)setupDefaultNavigationItemsForViewController:(UIViewController<TGNavigationResponder> *)viewController
{
    if ([viewController respondsToSelector:@selector(navigationController)])
    {
        
        BOOL showBackButton = NO;
        NSString *backButtonTitle = nil;
        
        // determine if we should show the back button or not
        if (viewController.navigationController && !viewController.navigationItem.hidesBackButton)
        {
            NSArray *items = viewController.navigationController.navigationBar.items;
            
            if (items.count > 0)
            {
                NSInteger index = [items indexOfObject:viewController.navigationItem];
                
                if (index == NSNotFound)
                    index = items.count;
                
                if (index > 0)
                {
                    index--;
                    
                    UINavigationItem *previous = [items objectAtIndex:index];
                    
                    NSString *title = previous.backBarButtonItem.title;
                    
                    if (!title)
                        title = previous.title;
                    
                    showBackButton = YES;
                    backButtonTitle = title;
                }
            }
        }
        
        if (!showBackButton)
        {
            UIBarButtonItem *menuBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStylePlain target:viewController action:@selector(menuTapped)];
        
            [viewController.navigationItem setLeftBarButtonItem:menuBarButtonItem];
        }
    }
}

@end
