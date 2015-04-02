//
//  AppointmentManager.h
//  ScheduleMe
//
//  Created by jchavezk on 4/1/15.
//  Copyright (c) 2015 JCKortlang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Appointment.h"

@interface AppointmentManager : NSObject

@property NSArray* appointments;
@property NSArray* currentUsersAppointments;

+(AppointmentManager*) getInstance;
-(void)scheduleAppointmentOn:(NSDate*)aDate ForTimeslot:(NSNumber*) aTimeslot;
-(void)getAppointmentsForDate:(NSDate*)aDate;
-(void)getAppointmentsForCurrentUser;
-(bool)checkTimeslotAvailability:(NSNumber*) aTimeslot;

@end
