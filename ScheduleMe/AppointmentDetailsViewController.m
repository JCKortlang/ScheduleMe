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
    self.companyLabel.text = [NSString stringWithFormat:@"With %@",self.selectedAppointment.forCompany.name];
    self.dateLabel.text = [NSString stringWithFormat:@"On %@ at %@", [Appointment dateOnlyDescriptionFromDate:self.selectedAppointment.onDate], [Appointment timeDescriptionFromStartingTime:9 WithTimeslot:[self.selectedAppointment.forTimeslot longValue]]];
    
    float latitude = self.selectedAppointment.forCompany.location.latitude;
    float longitude = self.selectedAppointment.forCompany.location.longitude;
    self.addressLabel.text = [NSString stringWithFormat:@"Address: (%.6f,%.6f)", latitude, longitude];
    
    [self.mapView addAnnotation:self.selectedAppointment];
    
    MKCoordinateSpan span;
    span.latitudeDelta = .003;
    span.longitudeDelta = .003;
    
    MKCoordinateRegion region;
    region.center = self.selectedAppointment.coordinate;
    region.span = span;
    
    self.mapView.region = region;
    
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
