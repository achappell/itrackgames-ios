//
//  TGViewController.m
//  iTrackGames
//
//  Created by Amanda Chappell on 2/17/13.
//  Copyright (c) 2013 Amanda Chappell. All rights reserved.
//

#import "TGViewController.h"
#import <RestKit/RestKit.h>
#import "TGPlatform.h"

@interface TGViewController ()

@end

@implementation TGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self fetchData];
}

-(void) fetchData
{
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    
    [objectManager getObjectsAtPath:@"/platforms.json" parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        NSArray *platforms = [mappingResult array];
        NSLog(@"Loaded platforms: %@", platforms);
        self.platforms = platforms;
        [self.tableView reloadData];
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
    }];
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
    TGPlatform *platform = [_platforms objectAtIndex:indexPath.row];
    cell.textLabel.text = platform.name;
    
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
