//
//  TGRatingView.h
//  iTrackGames
//
//  Created by Amanda Chappell on 5/5/13.
//  Copyright (c) 2013 Amanda Chappell. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TGRatingDelegate;

@interface TGRatingView : UIView

@property (nonatomic, strong) NSMutableArray *stars;
@property (nonatomic, weak) id<TGRatingDelegate> delegate;

@end

@protocol TGRatingDelegate <NSObject>

- (void)ratingView:(TGRatingView *)ratingView didTapRatingStar:(NSInteger)starIndex;

@end