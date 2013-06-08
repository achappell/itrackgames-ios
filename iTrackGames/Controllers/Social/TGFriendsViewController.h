//
//  TGFriendsViewController.h
//  iTrackGames
//
//  Created by Amanda Chappell on 6/8/13.
//  Copyright (c) 2013 Amanda Chappell. All rights reserved.
//

#import "TGViewController.h"
#import "TGFriendsDataSource.h"

@interface TGFriendsViewController : TGViewController <UITableViewDataSource, UITableViewDelegate, TGViewDataSourceDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end
