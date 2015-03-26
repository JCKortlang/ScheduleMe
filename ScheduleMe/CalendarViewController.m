//
//  CalendarViewController.m
//  ScheduleMe
//
//  Created by jchavezk on 3/26/15.
//  Copyright (c) 2015 JCKortlang. All rights reserved.
//

#import "CalendarViewController.h"
#import "TSQCalendarView.h"

@interface CalendarViewController ()

@property TSQCalendarView* calenderView;

@end

@implementation CalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.calenderView = [[TSQCalendarView alloc] init];
    self.calenderView.firstDate = [[NSDate alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
