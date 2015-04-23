//
//  AppointmentTableCellTableViewCell.h
//  ScheduleMe
//
//  Created by jchavezk on 4/1/15.
//  Copyright (c) 2015 JCKortlang. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString* const APPOINTMENT_CELL_IDENTIFIER;

@protocol AppointmentReservation <NSObject>

@required
-(IBAction)reserveButtonClicked:(id)sender;

@end

@interface AppointmentTableViewCell : UITableViewCell

@property id<AppointmentReservation> delegate;

@property NSNumber* timeSlot;

@property bool isAvailable;

@property (weak, nonatomic) IBOutlet UIButton *reserveButton;

@property (weak, nonatomic) IBOutlet UILabel *availableMessage;

@property (weak, nonatomic) IBOutlet UILabel *time;

-(IBAction)buttonClicked:(id)sender;

-(void)setReservedStyle;

-(void)setConflictStyle;

@end
