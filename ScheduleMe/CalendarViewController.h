//
//  CalendarViewController.h
//  ScheduleMe
//
//  Created by jchavezk on 4/1/15.
//  Copyright (c) 2015 JCKortlang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimesSquare.h"

@interface CalendarViewController : UIViewController <TSQCalendarViewDelegate>

@property (nonatomic,strong) NSCalendar* calendar;
@property NSDate* selectedDate;

@end
