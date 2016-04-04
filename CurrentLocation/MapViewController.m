//
//  MapViewController.m
//  CurrentLocation
//
//  Created by ammarali on 18/01/16.
//  Copyright © 2016 Ammar. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()


@end

@implementation MapViewController
@synthesize lblLatitude,lblLongitude,myMapView,txtAddressView;


- (void)viewDidLoad {
    [super viewDidLoad];
    myMapView.delegate =self;
    locationManager=[[CLLocationManager alloc]init];
    locationManager.delegate=self;
    locationManager.desiredAccuracy=kCLLocationAccuracyBest;
    [locationManager requestAlwaysAuthorization];
    [locationManager requestWhenInUseAuthorization];
    [myMapView setShowsUserLocation:YES];
    [locationManager startUpdatingLocation];
    
    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    CLLocation *currentLocation=newLocation;
    if (currentLocation!=nil)
    {
        lblLatitude.text=[NSString stringWithFormat:@"%f",currentLocation.coordinate.latitude];
        lblLongitude.text=[NSString stringWithFormat:@"%f",currentLocation.coordinate.longitude];
    }
    
    // performing reverse geocoding
    
    CLGeocoder *geocoder=[[CLGeocoder alloc]init];
    CLLocation *updatedLocation=[[CLLocation alloc]initWithLatitude:currentLocation.coordinate.latitude longitude:currentLocation.coordinate.longitude];
    [geocoder reverseGeocodeLocation:updatedLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error)
     {
      if (placemarks && placemarks.count>0)
         {
             CLPlacemark *placemark=placemarks[0];
             NSDictionary *addressDict=placemark.addressDictionary;
             NSString *state=[addressDict valueForKey:@"State"];
             NSString *zip=[addressDict valueForKey:@"ZIP"];
             NSString *locality=[addressDict valueForKey:@"SubLocality"];
             NSString *city=[addressDict valueForKey:@"City"];
             NSString *country=[addressDict valueForKey:@"Country"];
             txtAddressView.text = [NSString stringWithFormat:@"%@, %@ %@, %@, %@", locality, city, state, country,zip];
             myMapView.userLocation.title=[NSString stringWithFormat:@"%@,%@",city,state];
             myMapView.userLocation.subtitle=[NSString stringWithFormat:@"%@,%@ ",country,zip];
             
         }
    }];
    
}

-(void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
    // method used to animate pin or current user location
    nextRegion=YES;
    animated=nextRegion;
    
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    
    static NSString *annotationIdentifier=@"CurrentLocation";
    MKPinAnnotationView *annotationView=(MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:annotationIdentifier];
    if (annotationView == nil)
        {
            annotationView=[[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:annotationIdentifier];
            annotationView.animatesDrop=YES;
            [annotationView setEnabled:YES];
            annotationView.canShowCallout=YES;
            annotationView.draggable=YES;
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            button.frame = CGRectMake(0, 0, 23, 23);
            annotationView.rightCalloutAccessoryView = button;
        }
    else
        {
            annotationView.annotation=annotation;
        }
    annotationView.draggable=YES;
    return annotationView;
}
-(void)zoomInMap
{
    MKCoordinateRegion region;
    CLLocationCoordinate2D center;
    center.latitude=locationManager.location.coordinate.latitude;
    center.longitude=locationManager.location.coordinate.longitude;
    MKCoordinateSpan span;
    span.latitudeDelta=5.0f;
    span.longitudeDelta=5.0f;
    region.center=center;
    region.span=span;
    [myMapView setRegion:region animated:YES];
}

-(void)zoomOutMap
{
    MKCoordinateRegion region;
    region.span.latitudeDelta=region.span.latitudeDelta*4;
    region.span.longitudeDelta=region.span.longitudeDelta*4;
    region.center.latitude=myMapView.centerCoordinate.latitude;
    region.center.longitude=myMapView.centerCoordinate.longitude;
    [myMapView setRegion:region animated:YES];
}
-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    [self zoomInMap];
    
}


@end
