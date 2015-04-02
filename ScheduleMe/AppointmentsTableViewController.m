//
//  AppointmentsTableViewController.m
//  ScheduleMe
//
//  Created by jchavezk on 4/1/15.
//  Copyright (c) 2015 JCKortlang. All rights reserved.
//

#import "AppointmentsTableViewController.h"
#import "AppointmentManager.h"

@interface AppointmentsTableViewController ()

@property long firtAppointmentTime;
@property NSNumber* selectedIndex;

@end

@implementation AppointmentsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Only one reservation at a time.
    self.tableView.allowsMultipleSelection = false;
    
    self.firtAppointmentTime = 9;
    
    UINib *cellNib = [UINib nibWithNibName:APPOINTMENT_CELL_IDENTIFIER bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:APPOINTMENT_CELL_IDENTIFIER];
    
    //Set the NavItem title to the date.
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    formatter.timeStyle = NSDateFormatterFullStyle;
    formatter.dateStyle = NSDateFormatterFullStyle;
    self.navigationItem.title = [formatter stringFromDate:self.selectedDate];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)reserveButtonClicked:(id)sender
{
    [[AppointmentManager getInstance] scheduleAppointmentOn:self.selectedDate ForTimeslot:self.selectedIndex];
    // Force the table view to redraw itself.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString* MyIdentifier = APPOINTMENT_CELL_IDENTIFIER;
    
    AppointmentTableViewCell *cell = (AppointmentTableViewCell*)[tableView dequeueReusableCellWithIdentifier:MyIdentifier forIndexPath:indexPath];
    
    if(cell == nil)
    {
        //We create the style.
        NSArray* nib = [[NSBundle mainBundle] loadNibNamed:MyIdentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    
    cell.timeSlot = [[NSNumber alloc]initWithInteger:indexPath.row];
    cell.isAvailable = [[AppointmentManager getInstance] checkTimeslotAvailability:cell.timeSlot];
    cell.availableMessage.text = cell.isAvailable ? @"Available" : @"Reserved";
    
    //Hacky but sufficient for a prototype.
    long time = self.firtAppointmentTime + indexPath.row;
    NSString* timeAffix = time >= 12 ? @"PM" : @"AM";
    time = time % 12;
    time = time == 0 ? 12 : time;
    
    cell.time.text = [NSString stringWithFormat:@"%ld:00 %@", time, timeAffix];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    self.selectedIndex = [[NSNumber alloc] initWithInteger:indexPath.row];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
