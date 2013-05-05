//
//  TGImageViewController.m
//  iTrackGames
//
//  Created by Toni White on 4/28/13.
//  Copyright (c) 2013 Amanda Chappell. All rights reserved.
//

#import "TGImageViewController.h"

@interface TGImageViewController ()

@end

@implementation TGImageViewController

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
    
    [self.imageView setImageContentMode:UIViewContentModeScaleAspectFit];
    [self.imageView displayImageFromURL:self.imageURL];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
