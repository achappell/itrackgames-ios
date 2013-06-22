//
//  TGAppDelegate.m
//  iTrackGames
//
//  Created by Amanda Chappell on 2/17/13.
//  Copyright (c) 2013 Amanda Chappell. All rights reserved.
//

#import "TGAppDelegate.h"
#import "TGPlatformTableViewController.h"
#import <RestKit/RestKit.h>
#import "TGPlatform.h"
#import "TGGame.h"
#import "TGImage.h"
#import "TestFlight.h"
#import <ViewDeck/IIViewDeckController.h>
#import "TGLoginViewController.h"
#import "TGMenuViewController.h"
#import <Facebook-iOS-SDK/FacebookSDK/Facebook.h>
#import "TGUserManager.h"
#import "TGSearchViewController.h"
#import <Crashlytics/Crashlytics.h>
#import "TGFacebookPlatform.h"
#import "TGFriendsViewController.h"
#import "TGSocialManager.h"

@interface TGAppDelegate()

@property (nonatomic, strong) IIViewDeckController *menuContainerViewController;

@end

@implementation TGAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [TestFlight takeOff:@"1d73c277-c17e-4d56-ac9a-44fde4a30468"];
    
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    [self initializeRestKit];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.window.rootViewController =  self.menuContainerViewController;
    
    [self.window makeKeyAndVisible];
    
    [Crashlytics startWithAPIKey:@"50b0f9977ba1eaf060cb5a1c57e5e932defa1b77"];

    //authenticate token stored in NSUserDefaults, if fails authentication show loginViewController
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [[TGUserManager sharedManager] authenticateWithToken:[defaults objectForKey:@"userLoginToken"] withCompletion:^(NSError *error) {
        if (error) {
            TGLoginViewController *loginViewController = [[TGLoginViewController alloc] initWithNibName:@"TGLoginViewController" bundle:nil];
            
            loginViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
            
            [self.window.rootViewController presentViewController:loginViewController animated:NO completion:nil];
        }
    }];
    
    [[TGSocialManager sharedManager] addSocialPlatform:[[TGFacebookPlatform alloc] init]];
    
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
    NSURL *baseURL = [NSURL URLWithString:@"http://itrackgames.com"];
    //NSURL *baseURL = [NSURL URLWithString:@"http://localhost:3000"];
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    
    [client setDefaultHeader:@"Accept" value:RKMIMETypeJSON];
    
    RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:client];
    
    RKObjectMapping *platformMapping = [RKObjectMapping mappingForClass:[TGPlatform class]];
    [platformMapping addAttributeMappingsFromDictionary:@{
        @"developer": @"developer",
        @"id": @"platform_id",
        @"name": @"name",
        @"overview": @"overview",
        @"rating": @"rating"
     }];
    
    RKObjectMapping *gameMapping = [RKObjectMapping mappingForClass:[TGGame class]];
    [gameMapping addAttributeMappingsFromDictionary:@{
     @"id": @"game_id",
     @"title": @"title",
     @"developer": @"developer",
     @"publisher": @"publisher",
     @"overview": @"overview",
     }];
    
    RKObjectMapping *imageMapping = [RKObjectMapping mappingForClass:[TGImage class]];
    [imageMapping addAttributeMappingsFromDictionary:@{
     @"type": @"type",
     @"location": @"location",
     @"id": @"image_id",
     }];
    
    RKObjectMapping *gameStashDatumMapping = [RKObjectMapping mappingForClass:[TGGameStashDatum class]];
    [gameStashDatumMapping addAttributeMappingsFromDictionary:@{
     @"has_played": @"hasPlayed",
     @"rating": @"rating"
     }];
    
    [gameMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"platform" toKeyPath:@"platform" withMapping:platformMapping]];
    [gameMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"game_stash_datum" toKeyPath:@"gameStashDatum" withMapping:gameStashDatumMapping]];
    [gameMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"images" toKeyPath:@"images" withMapping:imageMapping]];
    [platformMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"images" toKeyPath:@"images" withMapping:imageMapping]];
    
    RKResponseDescriptor *responseDescriptorPlatform = [RKResponseDescriptor responseDescriptorWithMapping:platformMapping pathPattern:@"/platforms.json" keyPath:nil statusCodes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(200, 99)]];
    
    RKResponseDescriptor *responseDescriptorGame = [RKResponseDescriptor responseDescriptorWithMapping:gameMapping pathPattern:@"/games.json" keyPath:nil statusCodes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(200, 99)]];
    
    RKResponseDescriptor *responseDescriptorIndivGame = [RKResponseDescriptor responseDescriptorWithMapping:gameMapping pathPattern:@"/games/:game_id.json" keyPath:nil statusCodes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(200, 99)]];
    
    RKResponseDescriptor *responseDescriptorIndivPlatform = [RKResponseDescriptor responseDescriptorWithMapping:platformMapping pathPattern:@"/platforms/:platform_id.json" keyPath:nil statusCodes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(200, 99)]];
    
    RKResponseDescriptor *responseDescriptorGameStashDatum = [RKResponseDescriptor responseDescriptorWithMapping:gameStashDatumMapping pathPattern:@"/game_stash_data.json" keyPath:nil statusCodes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(200, 99)]];
    
    RKResponseDescriptor *responseDescriptorSearch = [RKResponseDescriptor responseDescriptorWithMapping:gameMapping pathPattern:@"/search.json" keyPath:nil statusCodes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(200, 99)]];
    
    [objectManager addResponseDescriptor:responseDescriptorPlatform];
    [objectManager addResponseDescriptor:responseDescriptorGame];
    [objectManager addResponseDescriptor:responseDescriptorIndivGame];
    [objectManager addResponseDescriptor:responseDescriptorIndivPlatform];
    [objectManager addResponseDescriptor:responseDescriptorGameStashDatum];
    [objectManager addResponseDescriptor:responseDescriptorSearch];
    
    RKObjectMapping *gameStashDatumRequestMapping = [RKObjectMapping requestMapping];
    [gameStashDatumRequestMapping addAttributeMappingsFromDictionary:@{
     @"hasPlayed": @"has_played",
     @"rating": @"rating"
     }];
    
    RKRequestDescriptor *requestDescriptorGameStashDatum = [RKRequestDescriptor requestDescriptorWithMapping:gameStashDatumRequestMapping objectClass:[TGGameStashDatum class] rootKeyPath:@"game_stash_datum"];
    
    [objectManager addRequestDescriptor:requestDescriptorGameStashDatum];
}

- (IIViewDeckController *)menuContainerViewController
{
    if (!_menuContainerViewController)
    {
        
        // platforms
        TGPlatformTableViewController *platformViewController = [[TGPlatformTableViewController alloc] initWithNibName:@"TGPlatformTableViewController" bundle:nil];
        platformViewController.title = @"Platforms";
        UINavigationController *platformsNavigationController = [[UINavigationController alloc] initWithRootViewController:platformViewController];
        
        TGFriendsViewController *friendsViewController = [[TGFriendsViewController alloc] initWithNibName:@"TGFriendsViewController" bundle:nil];
        friendsViewController.title = @"Friends";
        UINavigationController *friendsNavigationController = [[UINavigationController alloc] initWithRootViewController:friendsViewController];
        
        TGSearchViewController *searchViewController = [[TGSearchViewController alloc] initWithNibName:@"TGSearchViewController" bundle:nil];

        TGMenuViewController *menuViewController = [[TGMenuViewController alloc] initWithNibName:@"TGMenuViewController" bundle:nil];
        menuViewController.viewControllers = @[ platformsNavigationController, friendsNavigationController ]; //platformsNavigationController, loginNavigationController
        
        _menuContainerViewController = [[IIViewDeckController alloc] initWithCenterViewController:platformsNavigationController leftViewController:menuViewController rightViewController:searchViewController];
        menuViewController.viewDeckController = _menuContainerViewController;
        platformViewController.viewDeckController = _menuContainerViewController;
        searchViewController.viewDeckController = _menuContainerViewController;

    }
    
    return _menuContainerViewController;
}

@end
