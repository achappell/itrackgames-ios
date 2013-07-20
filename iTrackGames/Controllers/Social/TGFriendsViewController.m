//
//  TGFriendsViewController.m
//  iTrackGames
//
//  Created by Amanda Chappell on 6/8/13.
//  Copyright (c) 2013 Amanda Chappell. All rights reserved.
//

#import "TGFriendsViewController.h"
#import "TGFriend.h"

@interface TGFriendsViewController ()

@property (nonatomic, strong) TGFriendsDataSource *dataSource;
@property (nonatomic, strong) NSArray *friends;

@end

@implementation TGFriendsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.tabBarItem.image = [UIImage imageNamed:@"friends_icon"];
    
    self.dataSource = [[TGFriendsDataSource alloc] init];
    self.dataSource.delegate = self;
    
    [self.dataSource reloadDataIfNeeded];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)friends
{
    return [self.dataSource friends];
}

#pragma mark - tableview datasource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.friends.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseIdentifier = @"Friend Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    }
    TGFriend *friend = [self.friends objectAtIndex:indexPath.row];
    cell.textLabel.text = friend.firstName;
    cell.detailTextLabel.text = friend.lastName;
    
    return cell;
}

#pragma mark - TGViewDataSourceDelegate

- (void)viewDataSourceDidUpdateContent:(id<TGViewDataSource>)dataSource
{
    [self.tableView reloadData];
}

- (void)viewDataSource:(id<TGViewDataSource>)dataSource didFailWithError:(NSError *)error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:error.localizedDescription delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
    [alert show];
}

@end
