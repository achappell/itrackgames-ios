//
//  TGAppDelegate.m
//  iTrackGames
//
//  Created by Amanda Chappell on 2/17/13.
//  Copyright (c) 2013 Amanda Chappell. All rights reserved.
//

#import "TGAppDelegate.h"
#import "TGViewController.h"
#import <RestKit/RestKit.h>
#import "TGPlatform.h"

@implementation TGAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    [self initializeRestKit];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self.viewController = [[TGViewController alloc] initWithNibName:@"TGViewController_iPhone" bundle:nil];
    } else {
        self.viewController = [[TGViewController alloc] initWithNibName:@"TGViewController_iPad" bundle:nil];
    }
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void) initializeRestKit
{
    NSURL *baseURL = [NSURL URLWithString:@"http://icheckgames.herokuapp.com"];
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    
    [client setDefaultHeader:@"Accept" value:RKMIMETypeJSON];
    
    RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:client];
    
    RKObjectMapping *platformMapping = [RKObjectMapping mappingForClass:[TGPlatform class]];
    [platformMapping addAttributeMappingsFromDictionary:@{
        @"developer": @"developer",
        @"id": @"platformID",
        @"name": @"name",
        @"overview": @"overview",
        @"rating": @"rating"
     }];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:platformMapping pathPattern:@"/platforms.json" keyPath:nil statusCodes:[NSIndexSet indexSetWithIndex:200]];
    
    [objectManager addResponseDescriptor:responseDescriptor];
}

@end
