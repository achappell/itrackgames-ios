//
//  TGGameViewController.m
//  iTrackGames
//
//  Created by Toni White on 2/24/13.
//  Copyright (c) 2013 Amanda Chappell. All rights reserved.
//

#import "TGGameViewController.h"
#import <RestKit/RestKit.h>

@interface TGGameViewController ()

@end

@implementation TGGameViewController

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
    [self fetchData];
}

-(void) fetchData
{
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    
    NSString *path = [NSString stringWithFormat:@"/games/%i.json",[self.game.game_id intValue]];
    
    [objectManager getObjectsAtPath:path parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        self.game = [mappingResult firstObject];
        [self populateText];
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        NSLog(@"Failed in fetchData.");
    }];
}

-(void) populateText
{
    self.titleLabel.text = self.game.title;
    self.developerLabel.text = self.game.developer;
    self.publisherLabel.text = self.game.publisher;
    self.overviewTextView.text = self.game.overview;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
