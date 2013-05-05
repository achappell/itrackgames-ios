//
//  TGGameViewController.m
//  iTrackGames
//
//  Created by Toni White on 2/24/13.
//  Copyright (c) 2013 Amanda Chappell. All rights reserved.
//

#import "TGGameViewController.h"
#import <RestKit/RestKit.h>
#import "TGGameDataSource.h"
#import "TGImageViewController.h"

@interface TGGameViewController ()

    @property (nonatomic, strong) TGGameDataSource *dataSource;

@end

static UIActivityIndicatorView *spinner;

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
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing = 5.0;
    
    CGRect collectionViewFrame = CGRectMake(0.0f, CGRectGetMaxY(self.overviewTextView.frame) + 10, self.view.frame.size.width, self.view.frame.size.height - CGRectGetMaxY(self.overviewTextView.frame) - 20);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:collectionViewFrame collectionViewLayout:flowLayout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [self.collectionView setBackgroundColor:[UIColor blueColor]];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    [self.view addSubview:self.collectionView];
    
    //start activity indicator animation
    [self beginLoadingData];
    
    self.dataSource = [[TGGameDataSource alloc] initWithGameId:self.gameId];
    self.dataSource.delegate = self;
    
    [self.dataSource reloadDataIfNeeded];
}

#pragma mark - Table view data source

- (TGGame *) game {
    
    return [self.dataSource game];
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

#pragma mark - Collection View Data Source 

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.game.images count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    MACachedImageView *imageView = [[MACachedImageView alloc] initWithFrame:cell.contentView.bounds];
    imageView.clipsToBounds = YES;
    NSURL *imageURL = [NSURL URLWithString: [[self.game.images objectAtIndex:indexPath.row] location]];
    [imageView displayImageFromURL:imageURL];
    [imageView setImageContentMode:UIViewContentModeScaleAspectFit];
    
    [cell.contentView addSubview:imageView];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(100, collectionView.bounds.size.height);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSURL *imageURL = [NSURL URLWithString: [[self.game.images objectAtIndex:indexPath.row] location]];
    
    TGImageViewController *viewController = [[TGImageViewController alloc] initWithNibName:@"TGImageViewController" bundle:nil];
    
    viewController.imageURL = imageURL;
    
    [self.navigationController pushViewController:viewController animated:YES];
}
#pragma mark - TGViewDataSourceDelegate

-(void)viewDataSourceDidUpdateContent:(id<TGViewDataSource>)dataSource
{
    [self populateText];
    [self.collectionView reloadData];
    [self finishLoadingData];
    
}

-(void)viewDataSource:(id<TGViewDataSource>)dataSource didFailWithError:(NSError *)error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:error.localizedDescription delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
    [alert show];
}

#pragma mark - Activity Indicator methods

-(void) beginLoadingData
{
    [self.titleLabel setHidden:YES];
    [self.developerLabel setHidden:YES];
    [self.publisherLabel setHidden:YES];
    [self.overviewTextView setHidden:YES];
    [self.collectionView setHidden: YES];
    
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = CGPointMake(self.view.bounds.size.width / 2.0f, self.view.bounds.size.height / 2.0f);
    spinner.autoresizingMask = (UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin);
    spinner.hidesWhenStopped = YES;
    [self.view addSubview:spinner];
    [spinner startAnimating];
}

-(void) finishLoadingData
{
    [spinner stopAnimating];
    [self.titleLabel setHidden:NO];
    [self.developerLabel setHidden:NO];
    [self.publisherLabel setHidden:NO];
    [self.overviewTextView setHidden:NO];
    [self.collectionView setHidden: NO];
}

@end
