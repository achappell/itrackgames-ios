//
//  TGLoginViewController.m
//  iTrackGames
//
//  Created by Toni White on 3/3/13.
//  Copyright (c) 2013 Amanda Chappell. All rights reserved.
//

#import "TGLoginViewController.h"
#import "TGUserManager.h"
#import "TGPlatformTableViewController.h"
#import <FacebookSDK/Facebook.h>

@interface TGLoginViewController ()

@end

@implementation TGLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loginButtonTapped:(id)sender
{
    NSString *username, *password;
    
    username = self.usernameTextField.text;
    password = self.passwordTextField.text;
    
    NSLog(@"%@ %@", username, password);
    
    [[TGUserManager sharedManager] loginWithUsername:username andPassword:password withCompletion:^(NSError *error) {
        
        if (!error)
        {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        else
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:error.localizedDescription delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
            [alertView show];
        }
    }];
}

#pragma mark - UITextFieldDelegateMethods
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)facebookLoginButtonTapped:(id)sender
{
    NSArray *permissions =
    [NSArray arrayWithObjects:@"email", nil];
    
    [FBSession openActiveSessionWithReadPermissions:permissions
                                       allowLoginUI:YES
                                  completionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
                                      if (!error) {
                                          NSString *fbToken = session.accessTokenData.accessToken;
                                          [[TGUserManager sharedManager] loginWithFacebookToken:fbToken withCompletion:^(NSError *error) {
                                              if (!error)
                                              {
                                                  [self dismissViewControllerAnimated:YES completion:nil];
                                              }
                                              else
                                              {
                                                  UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:error.localizedDescription delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
                                                  [alertView show];
                                              }
                                                  
                                          }];
                                      } else {
                                          UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:error.localizedDescription delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
                                          [alertView show];
                                      }
     
                                  }];
   
}

@end
