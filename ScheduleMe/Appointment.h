//
//  Appointment.h
//  ScheduleMe
//
//  Created by jchavezk on 4/1/15.
//  Copyright (c) 2015 JCKortlang. All rights reserved.
//

#import <Parse/Parse.h>
#import "Company.h"
#import <MapKit/MKAnnotation.h>

extern NSString* const APPOINTMENT_CLASSNAME;

@interface Appointment : PFObject <PFSubclassing, MKAnnotation>

@property (nonatomic, strong) PFUser* scheduledBy;
@property (nonatomic, strong) NSDate* onDate;
@property (nonatomic, strong) NSNumber* forTimeslot;
@property (nonatomic, strong) Company* forCompany;

+(NSString*)timeDescriptionFromStartingTime:(long)hourOfDay WithTimeslot:(long)aTimeslot;
+(NSString*)dateOnlyDescriptionFromDate:(NSDate*)aDate;

//MKAnnotation Protocol
@property(nonatomic, readonly, copy) NSString *subtitle;
@property(nonatomic, readonly, copy) NSString *title;
@property(nonatomic, readonly) CLLocationCoordinate2D coordinate;
-(void)setCoordinate:(CLLocationCoordinate2D)newCoordinate;


@end
