//
//  ViewController.h
//  CurrentLocation
//
//  Created by ammarali on 18/01/16.
//  Copyright © 2016 Ammar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@interface ViewController : UIViewController<CLLocationManagerDelegate>
{
    CLLocationCoordinate2D coords;
    CLLocationManager *locationManager;
    
    
}
@property (strong, nonatomic) IBOutlet UITextView *txtView;
@property (strong, nonatomic) IBOutlet UILabel *lblLatLong;
@property (strong, nonatomic) IBOutlet UITextView *txtAddressView;

- (IBAction)forwardGeocoding:(id)sender;
- (IBAction)reverseGeocoding:(id)sender;

@end
