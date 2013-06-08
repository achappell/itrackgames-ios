//
//  TGMenuViewController.h
//  iTrackGames
//
//  Created by Amanda Chappell on 3/30/13.
//  Copyright (c) 2013 Amanda Chappell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ViewDeck/IIViewDeckController.h>

@interface TGMenuViewController : TGViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *viewControllers;

@end
