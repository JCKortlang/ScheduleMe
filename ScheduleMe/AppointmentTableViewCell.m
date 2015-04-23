//
//  AppointmentTableCellTableViewCell.m
//  ScheduleMe
//
//  Created by jchavezk on 4/1/15.
//  Copyright (c) 2015 JCKortlang. All rights reserved.
//

#import "AppointmentTableViewCell.h"

NSString* const APPOINTMENT_CELL_IDENTIFIER = @"AppointmentTableViewCell";

@implementation AppointmentTableViewCell

- (void)awakeFromNib {
    // Initialization codes
    [self.reserveButton setHidden:true];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    if (selected && self.isAvailable)
    {
        [self.reserveButton setHidden:false];
    }
    else
    {
        [self.reserveButton setHidden:true];
    }
}

- (IBAction)buttonClicked:(id)sender
{
    if(self.delegate != nil)
    {
        [self.delegate reserveButtonClicked:self];
    }
}

-(void)setReservedStyle
{
    self.availableMessage.text = @"Reserved";
    self.availableMessage.textColor = [[UIColor alloc] initWithRed:255 green:0 blue:0 alpha:1];
}

-(void)setConflictStyle
{
    self.availableMessage.text = @"Conflict";
    self.availableMessage.textColor = [[UIColor alloc] initWithRed:255 green:0 blue:0 alpha:1];
}

@end
