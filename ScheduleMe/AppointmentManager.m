//
//  AppointmentManager.m
//  ScheduleMe
//
//  Created by jchavezk on 4/1/15.
//  Copyright (c) 2015 JCKortlang. All rights reserved.
//

#import "AppointmentManager.h"
#import <Parse/Parse.h>

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

-(void)scheduleAppointmentOn:(NSDate*)aDate ForTimeslot:(NSNumber*) aTimeslot
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
               [self getAppointmentsForCurrentUser];
           }
           else if (error != nil)
           {
               NSLog([error description]);
           }
        }];
    }
}

-(NSArray*) getAppointmentsForDate:(NSDate*) aDate
{
    __block NSArray* results = nil;
    
    if(aDate != nil)
    {
        PFQuery* query = [PFQuery queryWithClassName:APPOINTMENT_CLASSNAME];
        [query whereKey:@"onDate" equalTo:aDate];
        
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            
            if(error == nil)
            {
                results = objects;
            }
        }];
    }
    
    return results;
}

-(void) getAppointmentsForCurrentUser
{
    PFQuery* query = [PFQuery queryWithClassName:APPOINTMENT_CLASSNAME];
    [query whereKey:@"scheduledBy" equalTo:[PFUser currentUser]];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if(error == nil)
        {
            self.appointments = objects;
        }
    }];
}


@end
