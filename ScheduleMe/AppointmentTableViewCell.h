//
//  AppointmentTableCellTableViewCell.h
//  ScheduleMe
//
//  Created by jchavezk on 4/1/15.
//  Copyright (c) 2015 JCKortlang. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString* const APPOINTMENT_CELL_IDENTIFIER;

@interface AppointmentTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *availableMessage;

@property (weak, nonatomic) IBOutlet UILabel *time;

- (IBAction)buttonClicked:(id)sender;

@end
