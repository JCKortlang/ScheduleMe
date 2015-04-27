//
//  AppointmentDetailsViewController.h
//  ScheduleMe
//
//  Created by jchavezk on 4/23/15.
//  Copyright (c) 2015 JCKortlang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CLLocationManager.h>
#import <AddressBookUI/AddressBookUI.h>

#import "Appointment.h"

extern NSString* const APPOINTMENT_DETAILS_SEGUE;

@interface AppointmentDetailsViewController : UIViewController <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *companyLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property Appointment* selectedAppointment;

@end
