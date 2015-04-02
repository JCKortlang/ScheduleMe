//
//  AppointmentManager.m
//  ScheduleMe
//
//  Created by jchavezk on 4/1/15.
//  Copyright (c) 2015 JCKortlang. All rights reserved.
//

#import "AppointmentManager.h"
#import <Parse/Parse.h>

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

-(void) getAppointmentsForDate:(NSDate*) aDate
{
    if(aDate != nil)
    {
        PFQuery* query = [PFQuery queryWithClassName:APPOINTMENT_CLASSNAME];
        [query whereKey:@"onDate" equalTo:aDate];
        
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            
            if(error == nil)
            {
                self.appointments = objects;
            }
            else
            {
                NSLog(error.description);
            }
        }];
    }
}

-(void) getAppointmentsForCurrentUser
{
    PFQuery* query = [PFQuery queryWithClassName:APPOINTMENT_CLASSNAME];
    [query whereKey:@"scheduledBy" equalTo:[PFUser objectWithoutDataWithObjectId:[PFUser currentUser].objectId]];
    [query orderByAscending:@"forTimeslot"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if(error == nil)
        {
            self.currentUsersAppointments = objects;
        }
        else
        {
            NSLog(error.description);
        }
    }];
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
