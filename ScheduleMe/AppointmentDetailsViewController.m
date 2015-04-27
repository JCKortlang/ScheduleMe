//
//  AppointmentDetailsViewController.m
//  ScheduleMe
//
//  Created by jchavezk on 4/23/15.
//  Copyright (c) 2015 JCKortlang. All rights reserved.
//

#import "AppointmentDetailsViewController.h"

NSString* const APPOINTMENT_DETAILS_SEGUE = @"AppointmentDetailsSegue";

@interface AppointmentDetailsViewController ()

@end

@implementation AppointmentDetailsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self reverseGeocodeAppointmentLocation];
    
    // Do any additional setup after loading the view.
    [self navigationItem].title = @"Appointment Details";
    self.companyLabel.text = [NSString stringWithFormat:@"With %@",self.selectedAppointment.forCompany.name];
    self.dateLabel.text = [NSString stringWithFormat:@"On %@ at %@", [Appointment dateOnlyDescriptionFromDate:self.selectedAppointment.onDate], [Appointment timeDescriptionFromStartingTime:9 WithTimeslot:[self.selectedAppointment.forTimeslot longValue]]];
    
    float latitude = self.selectedAppointment.forCompany.location.latitude;
    float longitude = self.selectedAppointment.forCompany.location.longitude;
    self.addressLabel.text = [NSString stringWithFormat:@"Address: (%.6f,%.6f)", latitude, longitude];
    
    [self.mapView addAnnotation:self.selectedAppointment];
    
    // We add an initial region in order to have a propery animation effect.
    [self setMapViewRegionWithLatitiudeDelta:2 AndLongitudeDelta:2 WithAnimation:false];
}

-(void)mapViewDidFinishRenderingMap:(MKMapView *)mapView fullyRendered:(BOOL)fullyRendered
{
    if(fullyRendered)
    {
        [self setMapViewRegionWithLatitiudeDelta:.003 AndLongitudeDelta:.003 WithAnimation:fullyRendered];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setMapViewRegionWithLatitiudeDelta:(float)aLatitude AndLongitudeDelta:(float)aLongitude WithAnimation:(bool)animated
{
    MKCoordinateSpan span;
    span.latitudeDelta = aLatitude;
    span.longitudeDelta = aLongitude;
    
    MKCoordinateRegion region;
    region.center = self.selectedAppointment.coordinate;
    region.span = span;
    
    [self.mapView setRegion:region animated:animated];
}

-(void)reverseGeocodeAppointmentLocation
{
    CLGeocoder* geocoder = [[CLGeocoder alloc] init];
    
    CLLocationDegrees latitude = self.selectedAppointment.forCompany.location.latitude;
    CLLocationDegrees longitude = self.selectedAppointment.forCompany.location.longitude;
    
    CLLocation* location = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if (error == nil && placemarks != nil && placemarks.count > 0)
        {
            CLPlacemark* placemark = (CLPlacemark*)placemarks[0];
            
            NSString* address = ABCreateStringWithAddressDictionary(placemark.addressDictionary, YES);
            
            self.addressLabel.text = address;
        }
        
    }];
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
