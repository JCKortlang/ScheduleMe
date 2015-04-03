//
//  AppointmentManager.m
//  ScheduleMe
//
//  Created by jchavezk on 4/1/15.
//  Copyright (c) 2015 JCKortlang. All rights reserved.
//

#import "AppointmentManager.h"
#import <Parse/Parse.h>

long const START_TIMESLOT = 9;
long const TIMESLOT_COUNT = 8;

@interface AppointmentManager()

@end

@implementation AppointmentManager

static AppointmentManager* instance;

-(instancetype)init
{
    self = [super init];
    
    if (self)
    {
        self.appointments = nil;
    }
    return self;
}

+(AppointmentManager*) getInstance
{
    if(instance == nil)
    {
        instance = [[AppointmentManager alloc]init];
    }
    return instance;
}


-(void)scheduleAppointmentOn:(NSDate*)aDate ForTimeslot:(NSNumber*) aTimeslot WithCallback:(void(^)(bool success))callback
{
    if (aDate != nil && aTimeslot != nil)
    {
        Appointment* theAppointment = [Appointment object];
        theAppointment.forTimeslot = aTimeslot;
        theAppointment.onDate = aDate;
        theAppointment.scheduledBy = [PFUser currentUser];
        
        [theAppointment saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if(succeeded)
            {
                [self getAppointmentsForDate:aDate WithCallback:^(BOOL SUCCESS) {
                    callback(SUCCESS);
                }];
            }
            else if (error != nil)
            {
                callback(NO);
            }
        }];
    }
}

-(void)getAppointmentsForDate:(NSDate*)aDate WithCallback:(void(^)(BOOL SUCCESS))callback
{
    if(aDate != nil)
    {
        PFQuery* query = [PFQuery queryWithClassName:APPOINTMENT_CLASSNAME];
        [query whereKey:@"onDate" equalTo:aDate];
        
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            
            if(error == nil)
            {
                self.appointments = objects;
                callback(YES);
            }
            else
            {
                callback(NO);
            }
        }];
    }
}

-(void) getAppointmentsForCurrentUserWithCallback:(void(^)(bool didSucceed))callback
{
    PFQuery* query = [PFQuery queryWithClassName:APPOINTMENT_CLASSNAME];
    [query whereKey:@"scheduledBy" equalTo:[PFUser objectWithoutDataWithObjectId:[PFUser currentUser].objectId]];
    [query orderByAscending:@"onDate"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if(error == nil)
        {
            self.currentUsersAppointments = objects;
            callback(YES);
        }
        else
        {
            callback(NO);
        }
    }];
}

-(void)cancelAppointment:(Appointment*)anAppointment WithCallback:(void(^)(bool didSucceed))callback
{
    if(anAppointment != nil)
    {
        [anAppointment deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            
            if(succeeded)
            {
                [self getAppointmentsForCurrentUserWithCallback:^(bool didSucceed) {
                    callback(didSucceed);
                }];
            }
            else
            {
                callback(succeeded);
            }
        }];
    }
    else
    {
        callback(NO);
    }
}

-(bool) checkTimeslotAvailability:(NSNumber*) aTimeslot
{
    bool result = true;
    
    for(int i = 0; i < self.appointments.count && result; i++)
    {
        Appointment* item = (Appointment*)[self.appointments objectAtIndex:i];
        result = ![item.forTimeslot isEqualToNumber:aTimeslot];
    }
    
    return result;
}


@end
