//
//  TGNavigationController.h
//  iTrackGames
//
//  Created by Amanda Chappell on 7/20/13.
//  Copyright (c) 2013 Amanda Chappell. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TGNavigationController : UINavigationController

- (id)initWithRootViewController:(UIViewController<TGNavigationResponder> *)rootViewController;

@end
