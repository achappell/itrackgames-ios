//
//  TGViewController.m
//  iTrackGames
//
//  Created by Amanda Chappell on 2/17/13.
//  Copyright (c) 2013 Amanda Chappell. All rights reserved.
//

#import "TGPlatformTableViewController.h"
#import <RestKit/RestKit.h>
#import "TGPlatform.h"
#import "TGGameTableViewController.h"

@interface TGPlatformTableViewController ()

@property (nonatomic, strong) TGPlatformsDataSource *dataSource;

@end

@implementation TGPlatformTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.dataSource = [[TGPlatformsDataSource alloc] init];
    self.dataSource.delegate = self;
    
    [self.dataSource reloadDataIfNeeded];
}

- (NSArray *)platforms
{
    return [self.dataSource platforms];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.platforms.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseIdentifier = @"Platform Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    TGPlatform *platform = [self.platforms objectAtIndex:indexPath.row];
    cell.textLabel.text = platform.name;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TGGameTableViewController *viewController = [[TGGameTableViewController alloc] initWithNibName:@"TGGameTableViewController" bundle:nil];
    
    viewController.platform = [self.platforms objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
