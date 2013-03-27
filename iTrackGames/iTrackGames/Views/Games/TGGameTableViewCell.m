//
//  TGGameTableViewCell.m
//  iTrackGames
//
//  Created by Amanda Chappell on 3/26/13.
//  Copyright (c) 2013 Amanda Chappell. All rights reserved.
//

#import "TGGameTableViewCell.h"
#import "TGGame.h"

@interface TGGameTableViewCell()

@property (nonatomic, strong) TGGame *game;

@end

@implementation TGGameTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
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

@end
