//
//  TGGameViewController.h
//  iTrackGames
//
//  Created by Toni White on 2/24/13.
//  Copyright (c) 2013 Amanda Chappell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TGGameDataSource.h"
#import "TGGame.h"
#import <MACachedImageView/MACachedImageView.h>


@interface TGGameViewController : TGViewController <TGViewDataSourceDelegate,UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) TGGame *game;
@property (nonatomic, strong) NSNumber *gameId;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *developerLabel;
@property (nonatomic, weak) IBOutlet UILabel *publisherLabel;
@property (nonatomic, weak) IBOutlet UITextView *overviewTextView;
@property (nonatomic, strong) UICollectionView *collectionView;

@end
