//
//  LogInViewController.h
//  ScheduleMe
//
//  Created by Ted Work on 3/31/15.
//  Copyright (c) 2015 JCKortlang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
@class LogInViewController;

@protocol loginProtocol <NSObject>


- (void)logInViewController:(LogInViewController *)logInController didLogInUser:(PFUser *)user;

@optional


-(void)LogInDelegateMethod:(LogInViewController *) sender;

//to dismiss the keyboard
-(IBAction)textFieldReturn:(id)sender;


@end

@interface LogInViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *LogInUsernameField;
@property (weak, nonatomic) IBOutlet UITextField *LogInPasswordField;
@property (weak, nonatomic) IBOutlet UIButton *LogInButton;

@property (weak, nonatomic) IBOutlet UIButton *SignUpVCSegueButton;
@property (weak, nonatomic) id <loginProtocol> delegate;

@end
