//
//  MapViewController.h
//  CurrentLocation
//
//  Created by ammarali on 18/01/16.
//  Copyright © 2016 Ammar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController <CLLocationManagerDelegate,MKMapViewDelegate,MKAnnotation>
{
    CLLocationManager *locationManager;
    CLGeocoder *geoCoder;
    BOOL nextRegion;
    
}
@property (strong, nonatomic) IBOutlet UILabel *lblLatitude;
@property (strong, nonatomic) IBOutlet UILabel *lblLongitude;
@property (strong, nonatomic) IBOutlet MKMapView *myMapView;
@property (strong, nonatomic) IBOutlet UITextView *txtAddressView;


@end
