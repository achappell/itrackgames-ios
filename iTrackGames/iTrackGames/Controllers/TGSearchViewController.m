//
//  TGSearchViewController.m
//  iTrackGames
//
//  Created by Amanda Chappell on 5/27/13.
//  Copyright (c) 2013 Amanda Chappell. All rights reserved.
//

#import "TGSearchViewController.h"
#import "TGSearchDataSource.h"
#import "TGGameTableViewCell.h"
#import "TGGameStashDatumMediator.h"

static NSString *reuseIdentifier = @"TGGameCell";

@interface TGSearchViewController ()

@property (nonatomic, strong) TGSearchDataSource *dataSource;
@property (nonatomic, strong) TGGameStashDatumMediator *gameStashDatumMediator;

@end

@implementation TGSearchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
         self.gameStashDatumMediator = [[TGGameStashDatumMediator alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UINib *nib = [UINib nibWithNibName:@"TGGameTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:reuseIdentifier];
    self.tableView.rowHeight = 80.0f;
    
    self.dataSource = [[TGSearchDataSource alloc] init];
    self.dataSource.delegate = self;
    
    [self.dataSource reloadDataIfNeeded];
}

- (NSArray *)searchResults
{
    return [self.dataSource searchResults];
}

#pragma mark - SearchBar Delegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    [self.dataSource fetchResultsForSearchTerm:searchBar.text];
}

#pragma mark - TGGameTableViewCellDelegate

- (void)gameTableViewCell:(TGGameTableViewCell *)cell didTapRatingStar:(NSInteger)starIndex
{
    [cell hideRatingsView];
    
    TGGame *game = [self.searchResults objectAtIndex:[self.tableView indexPathForCell:cell].row];
    
    [self.gameStashDatumMediator updateGame:game withPlayStatus:YES rating:starIndex];
    
    [self.tableView reloadData];
}

#pragma mark - actions

- (IBAction)checkBoxButtonTapped:(id)sender
{
    UIButton *checkButton = (UIButton *)sender;
    
    TGGameTableViewCell * cell = (TGGameTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:checkButton.tag inSection:0]];
    cell.delegate = self;
    
    [cell displayRatingsView];
}

#pragma mark - UITableView Delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.searchResults.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TGGameTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    TGGame *game = [self.searchResults objectAtIndex:indexPath.row];
    [cell setGame:game];
    
    cell.checkboxButton.tag = indexPath.row;
    [cell.checkboxButton addTarget:self action:@selector(checkBoxButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
