//
//  TGViewControllerGameList.m
//  iTrackGames
//
//  Created by Toni White on 2/17/13.
//  Copyright (c) 2013 Amanda Chappell. All rights reserved.
//

#import "TGGameTableViewController.h"
#import <RestKit/RestKit.h>
#import "TGGame.h"
#import "TGGameViewController.h"

@interface TGGameTableViewController ()

@property (nonatomic, strong) TGGamesDataSource *dataSource;

@end

@implementation TGGameTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.dataSource = [[TGGamesDataSource alloc] initWithPlatform:self.platform];
    self.dataSource.delegate = self;
    
    [self.dataSource reloadDataIfNeeded];
}

- (NSArray *) games {
    
    return [self.dataSource games];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.games.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseIdentifier = @"Platform Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    TGGame *game = [self.games objectAtIndex:indexPath.row];
    cell.textLabel.text = game.title;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TGGameViewController *viewController = [[TGGameViewController alloc] initWithNibName:@"TGGameViewController" bundle:nil];
    
    viewController.game = [self.games objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TGViewDataSourceDelegate

-(void)viewDataSourceDidUpdateContent:(id<TGViewDataSource>)dataSource
{
    [self.tableView reloadData];
}

-(void)viewDataSource:(id<TGViewDataSource>)dataSource didFailWithError:(NSError *)error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:error.localizedDescription delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
    [alert show];
}

@end
