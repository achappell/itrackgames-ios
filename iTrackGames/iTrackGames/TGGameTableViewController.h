//
//  TGViewControllerGameList.h
//  iTrackGames
//
//  Created by Toni White on 2/17/13.
//  Copyright (c) 2013 Amanda Chappell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TGPlatform.h"

@interface TGGameTableViewController : UIViewController

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *games;
@property (nonatomic, strong) TGPlatform *platform;
@end
