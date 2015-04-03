//
//  UserAppointmentTableViewCell.m
//  ScheduleMe
//
//  Created by jchavezk on 4/2/15.
//  Copyright (c) 2015 JCKortlang. All rights reserved.
//

#import "UserAppointmentTableViewCell.h"

NSString* const USER_APPOINTMENT_CELL_IDENTIFIER = @"UserAppointmentTableViewCell";

@implementation UserAppointmentTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [self.cancelButton setHidden:true];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    [self.cancelButton setHidden:!selected];
}

- (IBAction)cancelButton_OnTouchUp:(id)sender
{
    if (self.delegate != nil)
    {
        [self.delegate cancelButton_OnTouchUp:self];
    }
}
@end
