#import "LocationGetter.h"

@implementation LocationGetter

@synthesize locationManager, delegate,location;
BOOL didUpdate = NO;

- (void)startUpdates
{
    NSLog(@"Starting Location Updates");
    
    if (locationManager == nil)
        locationManager = [[CLLocationManager alloc] init];
    
    locationManager.delegate = self;

    locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    [locationManager startUpdatingLocation];
    location = [locationManager location];

    
}

-(void)stopUpdates
{
    [locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Location Service Disabled"
                                                    message:@"To re-enable, please go to Settings and turn on Location Service for this app."
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

// Delegate method from the CLLocationManagerDelegate protocol.
- (void)locationManager:(CLLocationManager *)manage didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    if (didUpdate){
        NSLog(@"did update!");
    }
        return;
    
    didUpdate = YES;
    // Disable future updates to save power.
    NSDate *eventDate = newLocation.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    //Is the event recent and accurate enough ?
    if (abs(howRecent) < 1) {
         [locationManager stopUpdatingLocation];
    }
   
    
    // let our delegate know we're done
    [delegate newPhysicalLocation:newLocation];
    location = [locationManager location];
    NSLog(@"location is %@",newLocation);
}

- (void)dealloc
{
    
}

@end