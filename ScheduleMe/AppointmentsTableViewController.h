//
//  AppointmentsTableViewController.h
//  ScheduleMe
//
//  Created by jchavezk on 4/1/15.
//  Copyright (c) 2015 JCKortlang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppointmentTableViewCell.h"
#import "Company.h"

@interface AppointmentsTableViewController : UITableViewController <AppointmentReservation>

@property Company* selectedCompany;
@property NSDate* selectedDate;
@property NSArray* appointments;

@end
