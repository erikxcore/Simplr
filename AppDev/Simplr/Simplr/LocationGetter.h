//
//  LocationGetter.h
//  CoreLocationExample
//
//  Created by Matt on 9/3/10.
//  Copyright 2009 iCodeBlog. All rights reserved.
//

#import <uikit/UIKit.h>
#import <coreLocation/CoreLocation.h>

@protocol LocationGetterDelegate
@required
- (void) newPhysicalLocation:(CLLocation *)location;
@end

@interface LocationGetter : NSObject  <CLLocationManagerDelegate>{
    CLLocationManager *locationManager;
    id delegate;
}

- (void)startUpdates;

@property (nonatomic, retain) CLLocationManager *locationManager;
@property(nonatomic , retain) id delegate;
@end