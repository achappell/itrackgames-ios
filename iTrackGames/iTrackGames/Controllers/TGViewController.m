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

- (UIImageView *)backgroundImageView
{
    if(!_backgroundImageView)
    {
        _backgroundImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        _backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
        
        [self.view addSubview:_backgroundImageView];
        [self.view sendSubviewToBack:_backgroundImageView];
    }
    
    return _backgroundImageView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [TGNavigationItemFactory setupDefaultNavigationItemsForViewController:self];
    
    UIImage *backgroundImage = [UIImage imageNamed:@"MainBackground2"];
    
    [self.backgroundImageView setImage:backgroundImage];
}

- (void)setBackgroundImage:(UIImage *)backgroundImage
{
    [self.backgroundImageView setImage:backgroundImage];
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
