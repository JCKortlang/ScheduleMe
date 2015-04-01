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

//methods FINISH THIS
-(void)LogInDelegateMethod:(LogInViewController *) sender;



@end

@interface LogInViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *LogInUsernameField;
@property (weak, nonatomic) IBOutlet UITextField *LogInPasswordField;
@property (weak, nonatomic) IBOutlet UIButton *LogInButton;

@property (weak, nonatomic) id <loginProtocol> delegate;

@end
