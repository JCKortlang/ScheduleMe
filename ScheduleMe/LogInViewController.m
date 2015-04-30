//
//  LogInViewController.m
//  ScheduleMe
//
//  Created by Ted Work on 3/31/15.
//  Copyright (c) 2015 JCKortlang. All rights reserved.
//

#import "LogInViewController.h"
#import "AppointmentManager.h"

@implementation LogInViewController

-(void)viewWillAppear:(BOOL)animated
{
    
}
- (IBAction)loginPressed:(id)sender {
    [self logUserIn];
}

//MINIMIZES KEYBOARD ON RETURN KEY
-(IBAction)textFieldReturn:(id)sender
{
    [sender resignFirstResponder];
}

//SHOULD MINIMIZE KEYBOARD WHEN BACKGROUND IS TOUCHED
-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    if ([self.LogInUsernameField isFirstResponder] && [touch view] != self.LogInUsernameField) {
        [self.LogInUsernameField resignFirstResponder];
    }
    if ([self.LogInPasswordField isFirstResponder] && [touch view] != self.LogInPasswordField) {
        [self.LogInPasswordField resignFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
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
        NSLog(@"The login failed");
    }
}
@end
