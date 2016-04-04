//
//  ViewController.m
//  CurrentLocation
//
//  Created by ammarali on 18/01/16.
//  Copyright © 2016 Ammar. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize txtView,lblLatLong,txtAddressView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)forwardGeocoding:(id)sender
{
    
    CLGeocoder *geocoder=[[CLGeocoder alloc]init];
    [geocoder geocodeAddressString:txtView.text completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        if (error)
        {
            NSLog(@"%@",error.localizedDescription);
        }
        if (placemarks && placemarks.count>0)
        {
            CLPlacemark *placemark=placemarks[0];
            CLLocation *location=placemark.location;
            coords=location.coordinate;
            lblLatLong.text=[NSString localizedStringWithFormat:@" Lat is :%f  Long is :%f",coords.latitude,coords.longitude];
        }
    }];

}

- (IBAction)reverseGeocoding:(id)sender
{
    CLLocation *newLocation=[[CLLocation alloc]initWithLatitude:coords.latitude longitude:coords.longitude];
        CLGeocoder * geocoder=[[CLGeocoder alloc]init];
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
       
        if (error)
        {
            NSLog(@"%@",error.localizedDescription);
            
        }
        if (placemarks && placemarks.count)
        {
            CLPlacemark *placemark=placemarks[0];
            NSDictionary *addressDict=placemark.addressDictionary;
            NSString *state=[addressDict valueForKey:@"State"];
            NSString *zip=[addressDict valueForKey:@"ZIP"];
            NSString *locality=[addressDict valueForKey:@"SubLocality"];
            NSString *city=[addressDict valueForKey:@"City"];
            NSString *country=[addressDict valueForKey:@"Country"];
             txtAddressView.text = [NSString stringWithFormat:@"%@, %@ %@, %@, %@", locality, city, state, country,zip];
          
        }
    }];
}
@end
