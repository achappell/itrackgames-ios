//
//  TGImageViewController.h
//  iTrackGames
//
//  Created by Toni White on 4/28/13.
//  Copyright (c) 2013 Amanda Chappell. All rights reserved.
//

#import "TGViewController.h"

@interface TGImageViewController : TGViewController

@property (nonatomic, strong) NSURL *imageURL;
@property (nonatomic, strong) IBOutlet UIImageView *imageView;

@end
