//
//  Company.h
//  ScheduleMe
//
//  Created by jchavezk on 4/23/15.
//  Copyright (c) 2015 JCKortlang. All rights reserved.
//

#import <Parse/Parse.h>

extern NSString* const COMPANY_CLASSNAME;

@interface Company : PFObject <PFSubclassing>

@property (nonatomic, strong) NSString* name;
@property (nonatomic,strong) PFGeoPoint* location;


@end
