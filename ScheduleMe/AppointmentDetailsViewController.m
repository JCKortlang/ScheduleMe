//
//  AppointmentDetailsViewController.m
//  ScheduleMe
//
//  Created by jchavezk on 4/23/15.
//  Copyright (c) 2015 JCKortlang. All rights reserved.
//

#import "AppointmentDetailsViewController.h"

NSString* const APPOINTMENT_DETAILS_SEGUE = @"AppointmentDetailsSegue";

@interface AppointmentDetailsViewController ()

@end

@implementation AppointmentDetailsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self navigationItem].title = @"Appointment Details";
    self.companyLabel.text = self.selectedAppointment.forCompany.name;
    self.datetimeLabel.text = [Appointment dateOnlyDescriptionFromDate:self.selectedAppointment.onDate];
}

- (void)didReceiveMemoryWarning
{
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
