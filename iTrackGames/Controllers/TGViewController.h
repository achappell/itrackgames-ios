//
//  TGViewController.h
//  iTrackGames
//
//  Created by Amanda Chappell on 3/30/13.
//  Copyright (c) 2013 Amanda Chappell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TGNavigationItemFactory.h"
#import <ViewDeck/IIViewDeckController.h>

@interface TGViewController : UIViewController <TGNavigationResponder>

@property (nonatomic, weak) IIViewDeckController *viewDeckController;
@property (nonatomic, strong) UIImageView *backgroundImageView;

- (void)setBackgroundImage:(UIImage *)backgroundImage;

@end
