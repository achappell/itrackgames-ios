//
//  TGViewController.m
//  iTrackGames
//
//  Created by Amanda Chappell on 3/30/13.
//  Copyright (c) 2013 Amanda Chappell. All rights reserved.
//

#import "TGViewController.h"

@interface TGViewController ()

@end

@implementation TGViewController

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
	// Do any additional setup after loading the view.
    
    [TGNavigationItemFactory setupDefaultNavigationItemsForViewController:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)menuTapped
{
    [self.viewDeckController openLeftViewAnimated:YES];
}

-(void)searchTapped
{
    [self.viewDeckController openRightViewAnimated:YES];
}

@end
