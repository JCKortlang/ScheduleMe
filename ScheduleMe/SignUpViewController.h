//
//  SignUpViewController.h
//  ScheduleMe
//
//  Created by Ted Work on 3/31/15.
//  Copyright (c) 2015 JCKortlang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class SignUpViewController;
@protocol signUpProtocol <NSObject>

// method here
-(void)SignUpDelegateMethod:(SignUpViewController *) sender;

@end

@interface SignUpViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *UserNameField;
@property (weak, nonatomic) IBOutlet UITextField *PasswordField;
@property (weak, nonatomic) IBOutlet UITextField *EmailField;
@property (weak, nonatomic) IBOutlet UITextField *FirstNameField;
@property (weak, nonatomic) IBOutlet UITextField *LastNameField;
@property (weak, nonatomic) IBOutlet UITextField *CompanyField;
@property (weak, nonatomic) IBOutlet UIButton *ConfirmSignupButton;


@property (weak, nonatomic) id<signUpProtocol> delegate;

@end
