//
//  Appointment.m
//  ScheduleMe
//
//  Created by jchavezk on 4/1/15.
//  Copyright (c) 2015 JCKortlang. All rights reserved.
//

#import "Appointment.h"

NSString* const APPOINTMENT_CLASSNAME = @"Appointment";

@implementation Appointment

@dynamic scheduledBy;
@dynamic forTimeslot;
@dynamic onDate;

+(void)load
{
    [self registerSubclass];
}
+(NSString*)parseClassName
{
    return APPOINTMENT_CLASSNAME;
}
@end
