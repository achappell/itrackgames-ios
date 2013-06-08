//
//  TGSearchViewController.h
//  iTrackGames
//
//  Created by Amanda Chappell on 5/27/13.
//  Copyright (c) 2013 Amanda Chappell. All rights reserved.
//

#import "TGViewController.h"
#import "TGGameTableViewCell.h"

@interface TGSearchViewController : TGViewController <UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate, TGGameTableViewCellDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *searchResults;

@end
