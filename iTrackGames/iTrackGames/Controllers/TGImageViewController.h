//
//  TGImageViewController.h
//  iTrackGames
//
//  Created by Toni White on 4/28/13.
//  Copyright (c) 2013 Amanda Chappell. All rights reserved.
//

#import "TGViewController.h"
#import <MACachedImageView/MACachedImageView.h>

@interface TGImageViewController : TGViewController

@property (nonatomic, strong) NSURL *imageURL;
@property (nonatomic, strong) IBOutlet MACachedImageView *imageView;

@end
