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
#import "TGPlatformViewController.h"
#import "TGSplitViewController.h"

@interface TGPlatformTableViewController ()

@property (nonatomic, strong) TGPlatformsDataSource *dataSource;
@property (nonatomic, strong) TGSplitViewController *splitViewController;

@end

@implementation TGPlatformTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.dataSource = [[TGPlatformsDataSource alloc] init];
    self.dataSource.delegate = self;
    
    [self.dataSource reloadDataIfNeeded];
    
    self.tabBarItem.image = [UIImage imageNamed:@"platform_icon"];
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
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CGRect cellRect = [tableView rectForRowAtIndexPath:indexPath];
    cellRect = [self.view convertRect:cellRect fromView:tableView];
    
    self.splitViewController = [[TGSplitViewController alloc] init];
    self.splitViewController.splitView = [self.view snapshotView];
    self.splitViewController.splitPoint = CGPointMake(0.0f, CGRectGetMaxY(cellRect));
    self.splitViewController.detailViewController = [[TGGameTableViewController alloc] initWithNibName:@"TGGameTableViewController" bundle:nil];
    
    TGGameTableViewController *viewController = (TGGameTableViewController *)self.splitViewController.detailViewController;
    viewController.platform = [self.platforms objectAtIndex:indexPath.row];
    
    [self.view addSubview:self.splitViewController.view];
    
    [self.splitViewController animateViewSplit];
    
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    TGPlatformViewController *viewController = [[TGPlatformViewController alloc] initWithNibName:@"TGPlatformViewController" bundle:nil];
    viewController.platformId = [(TGPlatform *)[self.platforms objectAtIndex:indexPath.row] platform_id];
    
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
