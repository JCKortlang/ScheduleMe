//
//  SignUpViewController.m
//  ScheduleMe
//
//  Created by Ted Work on 3/31/15.
//  Copyright (c) 2015 JCKortlang. All rights reserved.
//

#import "SignUpViewController.h"
#import <Parse/Parse.h>

@interface SignUpViewController ()

@end

@implementation SignUpViewController
@synthesize delegate;

- (void)viewDidAppear:(BOOL)animated{
    
}
- (IBAction)UserCreationConfirmed:(id)sender {
    
    [self.delegate SignUpDelegateMethod:self];
    
    //set all fields of the user object to those that were entered in the signup screen
    PFUser *User = [PFUser user];
    User.username = self.UserNameField.text;
    User.password = self.PasswordField.text;
    User.email = self.EmailField.text;
    NSString *firstname;
    NSString *lastname;
    NSString *organization;
    
    [User setValue: self.FirstNameField.text forKey: firstname];
    [User setValue: self.LastNameField.text forKey: lastname];
    [User setValue: self.CompanyField.text forKey: organization];

    //send the info to parse
    [User signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error) {
            // Display an alert view to show the error message
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[error userInfo][@"error"]
                                                                message:nil
                                                               delegate:self
                                                      cancelButtonTitle:nil
                                                      otherButtonTitles:@"OK", nil];
            [alertView show];
            // Bring the keyboard back up, because they probably need to change something.
            //[self.usernameField becomeFirstResponder];
            return;
        }
        
        // Handle the success path
        NSLog(@"success");
    }];
}


@end
