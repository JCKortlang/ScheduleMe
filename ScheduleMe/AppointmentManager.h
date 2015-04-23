//
//  AppointmentManager.h
//  ScheduleMe
//
//  Created by jchavezk on 4/1/15.
//  Copyright (c) 2015 JCKortlang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Appointment.h"

extern long const START_TIMESLOT;
extern long const TIMESLOT_COUNT;

@interface AppointmentManager : NSObject

@property NSArray* companies;
@property NSArray* appointments;
@property NSArray* currentUsersAppointments;
@property NSString* currentCompany;

+(AppointmentManager*) getInstance;
-(void)scheduleAppointmentOn:(NSDate*)aDate ForTimeslot:(NSNumber*) aTimeslot WithCallback:(void(^)(bool success))callback;
-(void)getAppointmentsForDate:(NSDate*)aDate WithCallback:(void(^)(BOOL SUCCESS))callback;
-(void)getAppointmentsForCurrentUserWithCallback:(void(^)(bool didSucceed))callback;
-(void)cancelAppointment:(Appointment*)anAppointment WithCallback:(void(^)(bool didSucceed))callback;
-(bool)checkTimeslotAvailability:(NSNumber*) aTimeslot;

@end
