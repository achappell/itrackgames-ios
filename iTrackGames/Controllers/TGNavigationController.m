//
//  TGNavigationController.m
//  iTrackGames
//
//  Created by Amanda Chappell on 7/20/13.
//  Copyright (c) 2013 Amanda Chappell. All rights reserved.
//

#import "TGNavigationController.h"
#import "TGNavigationItemFactory.h"

@interface TGNavigationController ()

@end

@implementation TGNavigationController

- (id)initWithRootViewController:(UIViewController<TGNavigationResponder> *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
    
        UINavigationItem *myNavItem = [[UINavigationItem alloc] init];
        [self.navigationBar setItems:@[myNavItem] animated: YES];
        
        [myNavItem setLeftBarButtonItem:[[TGNavigationItemFactory sharedNavFactory] menuButton:rootViewController]];
        [myNavItem setRightBarButtonItem:[[TGNavigationItemFactory sharedNavFactory] searchButton:rootViewController]];
        
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
