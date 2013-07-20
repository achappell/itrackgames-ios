//
//  TGPlatformViewController.h
//  iTrackGames
//
//  Created by Toni White on 4/21/13.
//  Copyright (c) 2013 Amanda Chappell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TGViewController.h"
#import "TGViewDataSource.h"

@interface TGPlatformViewController : TGViewController <TGViewDataSourceDelegate,UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
    @property (nonatomic, strong) TGPlatform *platform;
    @property (nonatomic, strong) NSNumber *platformId;
    @property (nonatomic, weak) IBOutlet UILabel *nameLabel;
    @property (nonatomic, weak) IBOutlet UILabel *developerLabel;
    @property (nonatomic, weak) IBOutlet UITextView *overviewTextView;
    @property (nonatomic, strong) UICollectionView *collectionView;
@end
