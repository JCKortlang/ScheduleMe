//
//  AccountDetailsViewController.h
//  ScheduleMe
//
//  Created by twork on 4/30/15.
//  Copyright (c) 2015 JCKortlang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountDetailsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *changeUsernameField;
@property (weak, nonatomic) IBOutlet UITextField *changePasswordField;
@property (weak, nonatomic) IBOutlet UITextField *changeEmailField;
@property (weak, nonatomic) IBOutlet UITextField *changeFirstnameField;
@property (weak, nonatomic) IBOutlet UITextField *changeLastnameField;
@property (weak, nonatomic) IBOutlet UITextField *changeCompanyField;
@property (strong, nonatomic) IBOutlet UIView *SubmitAccountChangesButton;

@end
