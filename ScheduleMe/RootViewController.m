//
//  ViewController.m
//  ScheduleMe
//
//  Created by jchavezk on 3/25/15.
//  Copyright (c) 2015 JCKortlang. All rights reserved.
//

#import "RootViewController.h"
#import "SignUpViewController.h"
#import "LogInViewController.h"
#import <Parse/Parse.h>

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIBarButtonItem* logoutButton = [[UIBarButtonItem alloc]init];
    logoutButton.title = @"Logout";
    [logoutButton setTarget:self];
    [logoutButton setAction:@selector(logoutButtonClicked)];
    
    [[self navigationItem] setRightBarButtonItem:logoutButton];
    
    [self updateUINavItemTitle];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (![PFUser currentUser].isAuthenticated)
    {
        [self showLoginViewController];
    }
}

-(void)showLoginViewController
{
    //do nothing if we have a user
    if([PFUser currentUser]) return;
    
    
//    LogInViewController *loginViewController = [[LogInViewController alloc] init];
    LogInViewController *loginViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LogInViewController"];
    //figure out the delegate stuff
    [loginViewController setDelegate:self];
    
    SignUpViewController* signupViewController = [[SignUpViewController alloc] init];
    //to define what fields we have to enter when we signup for a new account
    [signupViewController setDelegate:self];
    
    //[loginViewController setSignUpController:signupViewController];
    
    [self presentViewController:loginViewController animated:YES completion:nil];
}

-(void)logoutButtonClicked
{
    [PFUser logOutInBackgroundWithBlock:^(NSError* error)
     {
         if (error)
         {
             UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Logout Failed."
                                                             message:@"Please try again."
                                                            delegate:self
                                                   cancelButtonTitle:@"OK"
                                                   otherButtonTitles:nil, nil];
             [alert show];
         }
         else
         {
             [self showLoginViewController];
         }
     }];
}

-(void)updateUINavItemTitle
{
    
    NSString* welcomeString = @"";
    
    if ([PFUser currentUser].isAuthenticated)
    {
        welcomeString = [NSString stringWithFormat:@"Welcome %@",[PFUser currentUser].username];
    }
    
    [[self navigationItem] setTitle:welcomeString];
}

// Sent to the delegate to determine whether the log in request should be submitted to the server.
- (BOOL)logInViewController:(PFLogInViewController *)logInController shouldBeginLogInWithUsername:(NSString *)username password:(NSString *)password
{
    // Check if both fields are completed
    if (username && password && username.length != 0 && password.length != 0)
    {
        return YES; // Begin login process
    }
    
    [[[UIAlertView alloc] initWithTitle:@"Missing Information"
                                message:@"Make sure you fill out all of the information!"
                               delegate:nil
                      cancelButtonTitle:@"ok"
                      otherButtonTitles:nil] show];
    return NO; // Interrupt login process
}

// Sent to the delegate when a PFUser is logged in.
- (void)logInViewController:(LogInViewController *)logInController didLogInUser:(PFUser *)user
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

// Sent to the delegate when the log in attempt fails.
- (void)logInViewController:(LogInViewController *)logInController didFailToLogInWithError:(NSError *)error
{
    NSLog(@"Failed to log in...");
}

// Sent to the delegate when the log in screen is dismissed.
- (void)logInViewControllerDidCancelLogIn:(LogInViewController *)logInController
{
    [self.navigationController popViewControllerAnimated:YES];
}

// Sent to the delegate to determine whether the sign up request should be submitted to the server.
- (BOOL)signUpViewController:(SignUpViewController *)signUpController shouldBeginSignUp:(NSDictionary *)info
{
    BOOL informationComplete = YES;
    
    // loop through all of the submitted data
    for (id key in info) {
        NSString *field = [info objectForKey:key];
        if (!field || field.length == 0) { // check completion
            informationComplete = NO;
            break;
        }
    }
    
    // Display an alert if a field wasn't completed
    if (!informationComplete) {
        [[[UIAlertView alloc] initWithTitle:@"Missing Information"
                                    message:@"Make sure you fill out all of the information!"
                                   delegate:nil
                          cancelButtonTitle:@"ok"
                          otherButtonTitles:nil] show];
    }
    
    return informationComplete;
}

// Sent to the delegate when a PFUser is signed up.
- (void)signUpViewController:(SignUpViewController *)signUpController didSignUpUser:(PFUser *)user {
    [self dismissModalViewControllerAnimated:YES]; // Dismiss the PFSignUpViewController
}

// Sent to the delegate when the sign up attempt fails.
- (void)signUpViewController:(SignUpViewController *)signUpController didFailToSignUpWithError:(NSError *)error {
    NSLog(@"Failed to sign up...");
}

// Sent to the delegate when the sign up screen is dismissed.
- (void)signUpViewControllerDidCancelSignUp:(SignUpViewController *)signUpController {
    NSLog(@"User dismissed the signUpViewController");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
