#import <uikit/UIKit.h>
#import <coreLocation/CoreLocation.h>
#import <AddressBook/AddressBook.h>

@protocol LocationGetterDelegate
@required
- (void) newPhysicalLocation:(CLLocation *)location;

@end

@interface LocationGetter : NSObject  <CLLocationManagerDelegate>{
    CLLocationManager *locationManager;
    id delegate;
    CLLocation *location;
}

- (void)startUpdates;
- (void)stopUpdates;
@property(nonatomic, retain) CLLocationManager *locationManager;
@property(nonatomic , retain) id delegate;
@property(readonly, nonatomic) CLLocation *location;

@end