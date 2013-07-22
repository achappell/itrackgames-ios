//
//  TGSplitViewController.m
//  iTrackGames
//
//  Created by Amanda Chappell on 7/20/13.
//  Copyright (c) 2013 Amanda Chappell. All rights reserved.
//

#import "TGSplitViewController.h"

@interface TGSplitViewController ()

@property (nonatomic, strong) UIView *topContentView;
@property (nonatomic, strong) UIView *bottomContentView;

@end

@implementation TGSplitViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)splitView:(UIView *)view atPoint:(CGPoint)point
{
    self.topContentView = [view resizableSnapshotViewFromRect:CGRectMake(CGRectGetMinX(view.bounds), CGRectGetMinY(view.bounds), CGRectGetWidth(view.bounds), point.y) withCapInsets:UIEdgeInsetsZero];
    
    self.bottomContentView = [view resizableSnapshotViewFromRect:CGRectMake(CGRectGetMinX(view.bounds), point.y, CGRectGetWidth(view.bounds), CGRectGetHeight(view.bounds)-point.y) withCapInsets:UIEdgeInsetsZero];
    self.bottomContentView.center = CGPointMake(self.view.center.x, self.bottomContentView.center.y + self.topContentView.bounds.size.height);
    
    [self.view addSubview: self.topContentView];
    [self.view addSubview: self.bottomContentView];
    
    [self addChildViewController:self.detailViewController];
    [self.detailViewController willMoveToParentViewController:self];
    [self.view addSubview:self.detailViewController.view];
    [self.view sendSubviewToBack:self.detailViewController.view];
    [self.detailViewController didMoveToParentViewController:self];
    
    [self.detailViewController.view setFrame:CGRectMake(self.view.bounds.origin.x, CGRectGetMaxY(self.topContentView.frame), CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - CGRectGetHeight(self.topContentView.bounds))];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self splitView:self.splitView atPoint:self.splitPoint];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(collapseView)];
    [self.topContentView addGestureRecognizer:tapGesture];
}

- (void)collapseView
{
    [UIView animateWithDuration:0.7f animations:^{
        self.bottomContentView.center = CGPointMake(self.bottomContentView.center.x, self.bottomContentView.center.y - self.bottomContentView.bounds.size.height);
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
    }];
}

- (void)animateViewSplit
{
    [UIView animateWithDuration:0.7f animations:^{
        self.bottomContentView.center = CGPointMake(self.bottomContentView.center.x, self.bottomContentView.center.y + self.bottomContentView.bounds.size.height);
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
