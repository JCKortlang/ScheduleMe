//
//  UserAppointmentTableViewCell.h
//  ScheduleMe
//
//  Created by jchavezk on 4/2/15.
//  Copyright (c) 2015 JCKortlang. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString* const USER_APPOINTMENT_CELL_IDENTIFIER;

@interface UserAppointmentTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;


@end
