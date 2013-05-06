//
//  TGRatingView.m
//  iTrackGames
//
//  Created by Amanda Chappell on 5/5/13.
//  Copyright (c) 2013 Amanda Chappell. All rights reserved.
//

#import "TGRatingView.h"

@implementation TGRatingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat starWidth = (CGRectGetWidth(self.frame) - 60) / 5;
        
        for(int i=0; i<5; i++)
        {
            UIButton *starView = [UIButton buttonWithType:UIButtonTypeCustom];
            starView.frame = CGRectMake(10 + (i * (starWidth + 10)), 10, starWidth, CGRectGetHeight(self.frame) - 20);
            [starView addTarget:self action:@selector(starTapped:) forControlEvents:UIControlEventTouchUpInside];
            [starView setBackgroundImage:[UIImage imageNamed:@"star.gif"] forState:UIControlStateNormal];
            
            [self.stars addObject:starView];
            
            [self addSubview:starView];
        }
        
        [self setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.7]];
    }
    return self;
}

- (void)starTapped:(id)sender
{
    NSInteger starIndex = [self.stars indexOfObject:sender];
    
    [self.delegate ratingView:self didTapRatingStar:starIndex];
}

- (NSMutableArray *)stars
{
    if (!_stars)
        _stars = [[NSMutableArray alloc] init];
    
    return _stars;
}

@end
