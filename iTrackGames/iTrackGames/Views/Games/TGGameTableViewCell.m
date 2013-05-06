//
//  TGGameTableViewCell.m
//  iTrackGames
//
//  Created by Amanda Chappell on 3/26/13.
//  Copyright (c) 2013 Amanda Chappell. All rights reserved.
//

#import "TGGameTableViewCell.h"
#import "TGGame.h"
#import "TGRatingView.h"
#import <QuartzCore/QuartzCore.h>

@interface TGGameTableViewCell()

@property (nonatomic, strong) TGGame *game;
@property (nonatomic, strong) TGRatingView *ratingView;

@end

@implementation TGGameTableViewCell

- (void)awakeFromNib
{
    _ratingView = [[TGRatingView alloc] initWithFrame:CGRectMake(10, 10, CGRectGetWidth(self.bounds) - 20, CGRectGetHeight(self.bounds) - 20)];
    _ratingView.alpha = 0.0f;
    _ratingView.delegate = self;
    [self addSubview:_ratingView];
}

- (void)ratingView:(TGRatingView *)ratingView didTapRatingStar:(NSInteger)starIndex
{
    [self.delegate gameTableViewCell:self didTapRatingStar:starIndex];
}

- (void)setGame:(TGGame *)game
{
    _game = game;
    
    [self.titleLabel setText:_game.title];
    [self.platformLabel setText:_game.platform.name];
    
    [self setCheckboxStatus:[_game.gameStashDatum.hasPlayed boolValue]];
}

- (void)setCheckboxStatus:(BOOL)checked
{
    if (checked)
    {
        [self.checkboxButton setImage:[UIImage imageNamed:@"checkbox-checked"] forState:UIControlStateNormal];
        [self.checkboxButton setImage:[UIImage imageNamed:@"checkbox"] forState:UIControlStateHighlighted];
    }
    else
    {
        [self.checkboxButton setImage:[UIImage imageNamed:@"checkbox"] forState:UIControlStateNormal];
        [self.checkboxButton setImage:[UIImage imageNamed:@"checkbox-checked"] forState:UIControlStateHighlighted];
    }
}

- (void)displayRatingsView
{
    [UIView animateWithDuration:0.2 animations:^{
        self.ratingView.alpha = 1.0f;
    } completion:^(BOOL finished) {
        
        [self.ratingView.stars enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            UIView *starView = (UIView *)obj;
            
            CAKeyframeAnimation *animateGrow = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
            
            [animateGrow setValues:@[ @[@1, @1, @1], @[@1.2, @1.2, @1], @[@1, @1, @1]]];
            
            [animateGrow setValueFunction:[CAValueFunction functionWithName:kCAValueFunctionScale]];
            [animateGrow setDuration:0.5];
            animateGrow.beginTime = CACurrentMediaTime()+0.1*idx;
            
            [starView.layer addAnimation:animateGrow forKey:@"transform"];
        }];
    }];
}

- (void)hideRatingsView
{
    [UIView animateWithDuration:0.2 animations:^{
        self.ratingView.alpha = 0.0f;
    }];
}

@end
