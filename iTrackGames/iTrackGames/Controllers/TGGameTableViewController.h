//
//  TGViewControllerGameList.h
//  iTrackGames
//
//  Created by Toni White on 2/17/13.
//  Copyright (c) 2013 Amanda Chappell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TGGamesDataSource.h"
#import "TGPlatform.h"
#import "TGGameTableViewCell.h"

@interface TGGameTableViewController : TGViewController <UITableViewDelegate, UITableViewDataSource, TGViewDataSourceDelegate, TGGameTableViewCellDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *games;
@property (nonatomic, strong) TGPlatform *platform;

- (IBAction)checkBoxButtonTapped:(id)sender;

@end
