//
//  LogInViewController.m
//  ScheduleMe
//
//  Created by Ted Work on 3/31/15.
//  Copyright (c) 2015 JCKortlang. All rights reserved.
//

#import "LogInViewController.h"

@implementation LogInViewController

-(void)viewWillAppear:(BOOL)animated
{
    
}
- (IBAction)loginPressed:(id)sender {
    [self logUserIn];
}

//try to log the user in and let the delegate know about the results
-(void)logUserIn
{
    PFUser *user = [PFUser logInWithUsername:self.LogInUsernameField.text password:self.LogInPasswordField.text];
    
    if(user){
    
    [self.delegate logInViewController:self didLogInUser:[PFUser currentUser]];
        NSLog(@"Logged user in successfully!");
    }
    
    else{
        NSLog(@"The login failed ...?");
    }
}
@end
