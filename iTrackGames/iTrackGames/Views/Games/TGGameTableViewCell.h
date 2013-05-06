//
//  TGGameTableViewCell.h
//  iTrackGames
//
//  Created by Amanda Chappell on 3/26/13.
//  Copyright (c) 2013 Amanda Chappell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TGGame.h"
#import "TGRatingView.h"

@protocol TGGameTableViewCellDelegate;

@interface TGGameTableViewCell : UITableViewCell <TGRatingDelegate>

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *platformLabel;
@property (nonatomic, weak) IBOutlet UIButton *checkboxButton;
@property (nonatomic, weak) id<TGGameTableViewCellDelegate> delegate;

- (void)setGame:(TGGame *)game;
- (void)displayRatingsView;
- (void)hideRatingsView;

@end

@protocol TGGameTableViewCellDelegate <NSObject>

- (void)gameTableViewCell:(TGGameTableViewCell *)cell didTapRatingStar:(NSInteger)starIndex;

@end
