//
//  TGLoginViewController.h
//  iTrackGames
//
//  Created by Toni White on 3/3/13.
//  Copyright (c) 2013 Amanda Chappell. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TGLoginViewController : TGViewController <UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITextField *usernameTextField;
@property (nonatomic, weak) IBOutlet UITextField *passwordTextField;
@property (nonatomic, weak) IBOutlet UIButton *loginButton;

-(IBAction)loginButtonTapped:(id)sender;

@end
