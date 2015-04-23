//
//  CalendarViewController.m
//  ScheduleMe
//
//  Created by jchavezk on 4/1/15.
//  Copyright (c) 2015 JCKortlang. All rights reserved.
//

#import "CalendarViewController.h"
#import "TSQTACalendarRowCell.h"
#import "AppointmentsTableViewController.h"
#import "AppointmentManager.h"

@interface CalendarViewController ()

@property (nonatomic, strong) Company* selectedCompany;

@end

@interface TSQCalendarView (AccessingPrivateStuff)

@property (nonatomic, readonly) UITableView *tableView;

@end

@implementation CalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITableView* companies = [[UITableView alloc] init];
    [companies setDataSource:self];
    [companies setDelegate:self];
    
    UITableViewController* tableViewController = [[UITableViewController alloc]init];
    tableViewController.tableView = companies;
    tableViewController.modalPresentationStyle = UIModalPresentationFormSheet;
    
    [self presentViewController:tableViewController animated:true completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedCompany = [AppointmentManager getInstance].companies[indexPath.row];
    self.navigationItem.title = self.selectedCompany.name;
    [self dismissViewControllerAnimated:YES completion:^{
        //
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Company* company = [[AppointmentManager getInstance].companies objectAtIndex:indexPath.row];
    
    UITableViewCell* cell = [[UITableViewCell alloc]init];
    cell.textLabel.text = company.name;
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [AppointmentManager getInstance].companies == nil ? 0:[AppointmentManager getInstance].companies.count;
}

- (void)loadView;
{
    TSQCalendarView *calendarView = [[TSQCalendarView alloc] init];
    calendarView.calendar = self.calendar;
    calendarView.rowCellClass = [TSQTACalendarRowCell class];
    calendarView.firstDate = [[NSDate alloc]init];
    calendarView.lastDate = [NSDate dateWithTimeIntervalSinceNow:60 * 60 * 24 * 365 * 1];
    calendarView.backgroundColor = [UIColor colorWithRed:0.84f green:0.85f blue:0.86f alpha:1.0f];
    calendarView.pagingEnabled = YES;
    CGFloat onePixel = 1.0f / [UIScreen mainScreen].scale;
    calendarView.contentInset = UIEdgeInsetsMake(0.0f, onePixel, 0.0f, onePixel);
    calendarView.delegate = self;
    
    if(self.selectedDate != nil)
    {
        calendarView.selectedDate = self.selectedDate;
    }
    
    self.view = calendarView;
}

- (void)setCalendar:(NSCalendar *)calendar;
{
    _calendar = calendar;
    
    self.navigationItem.title = calendar.calendarIdentifier;
    self.tabBarItem.title = calendar.calendarIdentifier;
}

- (void)viewDidLayoutSubviews;
{
    // Set the calendar view to show today date on start
    [(TSQCalendarView *)self.view scrollToDate:[NSDate date] animated:NO];
}

- (void)scroll;
{
    static BOOL atTop = YES;
    TSQCalendarView *calendarView = (TSQCalendarView *)self.view;
    UITableView *tableView = calendarView.tableView;
    
    [tableView setContentOffset:CGPointMake(0.f, atTop ? 10000.f : 0.f) animated:YES];
    atTop = !atTop;
}

/** Asks the delegate whether a particular date is selectable.
 
 This method should be relatively efficient, as it is called repeatedly to appropriate enable and disable individual days on the calendar view.
 
 @param calendarView The calendar view that is selecting a date.
 @param date Midnight on the date being selected.
 @return Whether or not the date is selectable.
 */
- (BOOL)calendarView:(TSQCalendarView *)calendarView shouldSelectDate:(NSDate *)date
{
    NSDate* today = [[NSDate alloc]init];
    
    if ([date compare:today] == NSOrderedDescending)
    {
        return true;
    }
    else
    {
        return false;
    }
}

/** Tells the delegate that a particular date was selected.
 
 @param calendarView The calendar view that is selecting a date.
 @param date Midnight on the date being selected.
 */
- (void)calendarView:(TSQCalendarView *)calendarView didSelectDate:(NSDate *)date
{
    self.selectedDate = date;
    [[AppointmentManager getInstance] getAppointmentsForCompany:self.selectedCompany ForDate:date WithCallback:^(BOOL SUCCESS) {
        
        if (SUCCESS)
        {
            [self performSegueWithIdentifier:@"AppointmentSegue" sender:self];
        }
    }];
    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"AppointmentSegue"])
    {
        AppointmentsTableViewController* destinationViewController = segue.destinationViewController;
        destinationViewController.selectedDate = self.selectedDate;
        destinationViewController.selectedCompany = self.selectedCompany;
    }
}


@end
