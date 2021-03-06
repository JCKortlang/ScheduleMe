//
//  ViewController.h
//  ScheduleMe
//
//  Created by jchavezk on 3/25/15.
//  Copyright (c) 2015 JCKortlang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "RootViewController.h"
#import "SignUpViewController.h"
#import "LogInViewController.h"
#import "UserAppointmentTableViewCell.h"
#import "AppointmentDetailsViewController.h"

@import ParseUI;

@interface RootViewController : UITableViewController <PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate, loginProtocol, signUpProtocol, UITableViewDataSource, UITableViewDelegate>
@end

