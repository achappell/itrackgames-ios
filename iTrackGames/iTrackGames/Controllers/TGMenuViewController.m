//
//  TGMenuViewController.m
//  iTrackGames
//
//  Created by Amanda Chappell on 3/30/13.
//  Copyright (c) 2013 Amanda Chappell. All rights reserved.
//

#import "TGMenuViewController.h"
#import "TGPlatformTableViewController.h"
#import "TGLoginViewController.h"

@interface TGMenuViewController ()

@end

@implementation TGMenuViewController

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
    
    [self setBackgroundImage:[UIImage imageNamed:@"GradientBG1_Ret"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - table view dataSource/delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    
    UIViewController *viewController = [self.viewControllers objectAtIndex:indexPath.row];
    
    cell.textLabel.text = viewController.title;
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    [cell.imageView setImage:viewController.tabBarItem.image];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *viewController = [self.viewControllers objectAtIndex:indexPath.row];
    
    self.viewDeckController.centerController = viewController;
    [self.viewDeckController closeLeftViewAnimated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewControllers.count;
}

#pragma mark - login screen delegate
- (void)didLogin {
    NSLog(@"did login");
}

@end
