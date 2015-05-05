//
//  AccountDetailsViewController.m
//  ScheduleMe
//
//  Created by twork on 4/30/15.
//  Copyright (c) 2015 JCKortlang. All rights reserved.
//

#import "AccountDetailsViewController.h"
#import <Parse/Parse.h>

@interface AccountDetailsViewController ()

@end

@implementation AccountDetailsViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // Do any additional setup after loading the view.
    [self navigationItem].title = @"Change Account Details";
    
    
    //FETCH ACCOUNT DETAILS AND POPULATE THE TEXT FEILDS
    PFUser *User = [PFUser currentUser];
    
    NSString *firstname = @"firstname";
    NSString *lastname = @"lastname";
    NSString *organization = @"organization";
    
    self.changeUsernameField.text = User.username;
    self.changeEmailField.text = User.email;
    self.changeFirstnameField.text = [User valueForKey:firstname];
    self.changeLastnameField.text = [User valueForKey:lastname];
    self.changeCompanyField.text = [User valueForKey:organization];


}

//WILL SUBMIT CHANGES TO THE PARSE DICTIONARIES
- (IBAction)submitChangesClicked:(id)sender {
    PFUser *User = [PFUser currentUser];
    NSString *firstname = @"firstname";
    NSString *lastname = @"lastname";
    NSString *organization = @"organization";
    
    //SUBMITS THE CHANGES TO THE ACCOUNT DETAILS
    User.username = self.changeUsernameField.text;
    User.email = self.changeEmailField.text;
    if (self.changePasswordField.text != nil) {
        User.password = self.changePasswordField.text;
    }
    [User setValue:self.changeFirstnameField.text forKey:firstname];
    [User setValue:self.changeLastnameField.text forKey:lastname];
    [User setValue:self.changeCompanyField.text forKey:organization];
    
    [User saveEventually];
    
    //SUBMIT CHANGES TO PARSE
    //NEED TO IMPLEMENT
    
}

//MINIMIZEs KEYBOARD WHEN BACKGROUND IS TOUCHED
-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    //USERNAME
    if ([self.changeUsernameField isFirstResponder] && [touch view] != self.changeUsernameField) {
        [self.changeUsernameField resignFirstResponder];
    }
    //PASSWORD
    if ([self.changePasswordField isFirstResponder] && [touch view] != self.changePasswordField) {
        [self.changePasswordField resignFirstResponder];
    }
    //E-MAIL
    if ([self.changeEmailField isFirstResponder] && [touch view] != self.changeEmailField) {
        [self.changeEmailField resignFirstResponder];
    }
    //FIRSTNAME
    if ([self.changeFirstnameField isFirstResponder] && [touch view] != self.changeFirstnameField) {
        [self.changeFirstnameField resignFirstResponder];
    }
    //LASTNAME
    if ([self.changeLastnameField isFirstResponder] && [touch view] != self.changeLastnameField) {
        [self.changeLastnameField resignFirstResponder];
    }
    //ORGANIZATION
    if ([self.changeCompanyField isFirstResponder] && [touch view] != self.changeCompanyField) {
        [self.changeCompanyField resignFirstResponder];
    }
    
    [super touchesBegan:touches withEvent:event];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
