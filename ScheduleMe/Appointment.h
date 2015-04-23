//
//  Appointment.h
//  ScheduleMe
//
//  Created by jchavezk on 4/1/15.
//  Copyright (c) 2015 JCKortlang. All rights reserved.
//

#import <Parse/Parse.h>
#import "Company.h"

extern NSString* const APPOINTMENT_CLASSNAME;

@interface Appointment : PFObject <PFSubclassing>

@property (nonatomic, strong) PFUser* scheduledBy;
@property (nonatomic, strong) NSDate* onDate;
@property (nonatomic, strong) NSNumber* forTimeslot;
@property (nonatomic, strong) Company* forCompany;

+(NSString*)timeDescriptionFromStartingTime:(long)hourOfDay WithTimeslot:(long)aTimeslot;
+(NSString*)dateOnlyDescriptionFromDate:(NSDate*)aDate;

@end
