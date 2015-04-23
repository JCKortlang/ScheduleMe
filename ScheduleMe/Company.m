//
//  Company.m
//  ScheduleMe
//
//  Created by jchavezk on 4/23/15.
//  Copyright (c) 2015 JCKortlang. All rights reserved.
//

#import "Company.h"

NSString* const COMPANY_CLASSNAME = @"Company";

@implementation Company

@dynamic name;
@dynamic location;

+(void)load
{
    [self registerSubclass];
}
+(NSString*)parseClassName
{
    return COMPANY_CLASSNAME;
}

@end
