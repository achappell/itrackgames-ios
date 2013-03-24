//
//  TGViewController.h
//  iTrackGames
//
//  Created by Amanda Chappell on 2/17/13.
//  Copyright (c) 2013 Amanda Chappell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TGPlatformsDataSource.h"

@interface TGPlatformTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, TGViewDataSourceDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *platforms;

@end
