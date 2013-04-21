//
//  TGPlatformViewController.m
//  iTrackGames
//
//  Created by Toni White on 4/21/13.
//  Copyright (c) 2013 Amanda Chappell. All rights reserved.
//

#import "TGPlatformViewController.h"

@interface TGPlatformViewController ()

@end

@implementation TGPlatformViewController

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
    
    self.nameLabel.text = @"Test Platform Name";
    self.developerLabel.text = @"Test Developer Name";
    self.overviewTextView.text = @"Test Overview Text Test Overview Text Test Overview Text Test Overview Text Test Overview Text Test Overview Text Test Overview Text Test Overview Text Test Overview Text Test Overview Text Test Overview Text Test Overview Text Test Overview Text Test Overview Text Test Overview Text Test Overview Text Test Overview Text Test Overview Text Test Overview Text Test Overview Text Test Overview Text Test Overview Text Test Overview Text Test Overview Text Test Overview Text Test Overview Text Test Overview Text Test Overview Text Test Overview Text Test Overview Text Test Overview Text Test Overview Text Test Overview Text Test Overview Text Test Overview Text Test Overview Text ";
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
