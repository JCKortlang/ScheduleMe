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
#import "AppointmentManager.h"
#import "AppointmentTableViewCell.h"
#import "AppointmentsTableViewController.h"
#import <Parse/Parse.h>

@interface RootViewController()

@property NSArray* data;
@property long selectedIndex;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Prepare the reusable cell.
    UINib *cellNib = [UINib nibWithNibName:USER_APPOINTMENT_CELL_IDENTIFIER bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:USER_APPOINTMENT_CELL_IDENTIFIER];
    
    self.tableView.allowsMultipleSelection = false;
    
    UIBarButtonItem* logoutButton = [[UIBarButtonItem alloc]init];
    logoutButton.title = @"Logout";
    [logoutButton setTarget:self];
    [logoutButton setAction:@selector(logoutButtonClicked)];

    [[self navigationItem] setLeftBarButtonItem:logoutButton];
    
    UIBarButtonItem* makeAppointmentButton = [[UIBarButtonItem alloc] init];
    makeAppointmentButton.title = @"Schedule";
    [makeAppointmentButton setTarget:self];
    [makeAppointmentButton setAction:@selector(makeAppointmentButtonClicked)];
    
    [[self navigationItem] setRightBarButtonItem:makeAppointmentButton];
    
    [self updateUINavItemTitle];
}

-(void)viewWillAppear:(BOOL)animated
{
    [[AppointmentManager getInstance] getAppointmentsForCurrentUserWithCallback:^(bool didSucceed) {
        
        if (didSucceed)
        {
            self.data = [[AppointmentManager getInstance] currentUsersAppointments];
            NSLog(self.data.description);
            [self.tableView reloadData];
        }
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (![PFUser currentUser].isAuthenticated)
    {
        [self showLoginViewController];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
// this makes the cancel button appear
-(IBAction)cancelButton_OnTouchUp:(id)sender
{
    Appointment* appointment = (Appointment*)[self.data objectAtIndex:self.selectedIndex];
    
    [[AppointmentManager getInstance] cancelAppointment:appointment WithCallback:^(bool didSucceed){
        if(didSucceed)
        {
            self.data = [AppointmentManager getInstance].currentUsersAppointments;
            [self.tableView reloadData];
        }
    }];
}
 */

// TABLE VIEW CODE STARTS HERE !!

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.data != nil)
    {
        NSString* MyIdentifier = USER_APPOINTMENT_CELL_IDENTIFIER;
        
        UserAppointmentTableViewCell *cell = (UserAppointmentTableViewCell*)[tableView dequeueReusableCellWithIdentifier:MyIdentifier forIndexPath:indexPath];
         
        if(cell == nil)
        {
            //We create the style.
            NSArray* nib = [[NSBundle mainBundle] loadNibNamed:MyIdentifier owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }

        Appointment* appointment = (Appointment*)[self.data objectAtIndex:indexPath.row];
        
        long startTime = START_TIMESLOT;
        long timeSlot = [appointment.forTimeslot longValue];
        
        cell.delegate = self;
        cell.timeLabel.text = [Appointment timeDescriptionFromStartingTime:startTime WithTimeslot:timeSlot];
        cell.dateLabel.text = [Appointment dateOnlyDescriptionFromDate:appointment.onDate];
        
                return cell;
    }
    
    return nil;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedIndex = indexPath.row;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data == nil ? 0 : self.data.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

/* <--- added by Jake Irvin ---> */

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // get the selected appointment
    Appointment * appointment = (Appointment *)[self.data objectAtIndex:indexPath.row];
    
    // Call the cancelAppointment method to cancel the selected appointment
    [[AppointmentManager getInstance] cancelAppointment:appointment WithCallback:^(bool didSucceed){
        if(didSucceed)
        {
            // reset self.data after appointment canceled
            self.data = [AppointmentManager getInstance].currentUsersAppointments;
            // animate the cell being deleted
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
    }];
}

/* <---- END added by Jake Irvin ----> */

-(void)showLoginViewController
{
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

-(void)makeAppointmentButtonClicked
{
    [self performSegueWithIdentifier:@"CalendarSegue" sender:self];
}

-(void)updateUINavItemTitle
{
    [[self navigationItem] setTitle:@"Your Appointments"];
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
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

// Sent to the delegate when the sign up attempt fails.
- (void)signUpViewController:(SignUpViewController *)signUpController didFailToSignUpWithError:(NSError *)error {
    NSLog(@"Failed to sign up...");
}

// Sent to the delegate when the sign up screen is dismissed.
- (void)signUpViewControllerDidCancelSignUp:(SignUpViewController *)signUpController {
    NSLog(@"User dismissed the signUpViewController");
}

@end
