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
@dynamic forCompany;

-(CLLocationCoordinate2D) coordinate
{
    CLLocationCoordinate2D _coordinate;
    _coordinate.latitude = self.forCompany.location.latitude;
    _coordinate.longitude = self.forCompany.location.longitude;
    return _coordinate;
}

-(NSString*) title
{
    return self.forCompany.name;
}

-(NSString*) subtitle
{
    return [NSString stringWithFormat:@"On %@ at %@", [Appointment dateOnlyDescriptionFromDate:self.onDate],[Appointment timeDescriptionFromStartingTime:9 WithTimeslot:[self.forTimeslot longValue]]];
}


+(void)load
{
    [self registerSubclass];
}
+(NSString*)parseClassName
{
    return APPOINTMENT_CLASSNAME;
}

+(NSString*)timeDescriptionFromStartingTime:(long)hourOfDay WithTimeslot:(long)aTimeslot
{
    NSString* result = nil;
    
    //Hacky but sufficient for a prototype.
    long time = hourOfDay + aTimeslot;
    NSString* timeAffix = time >= 12 ? @"PM" : @"AM";
    time = time % 12;
    time = time == 0 ? 12 : time;
    result = [NSString stringWithFormat:@"%ld:00 %@", time, timeAffix];
    
    return result;
}

+(NSString*)dateOnlyDescriptionFromDate:(NSDate*)aDate
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    formatter.timeStyle = NSDateFormatterNoStyle;
    formatter.dateStyle = NSDateFormatterFullStyle;
    return [formatter stringFromDate:aDate];
}

//MKAnnotation
-(void)setCoordinate:(CLLocationCoordinate2D)newCoordinate
{
    self.forCompany.location.latitude = newCoordinate.latitude;
    self.forCompany.location.longitude = newCoordinate.longitude;
}

@end
