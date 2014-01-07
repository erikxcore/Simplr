//
//  HomeViewController.h
//  Simplr
//
//  Created by Eric on 2/21/13.
//  Copyright (c) 2013 District 7. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "LocationGetter.h"

@interface HomeViewController : UIViewController{
    BOOL locationAllowed;
}

@property (strong, nonatomic) IBOutlet UIButton *dealsButton;
@property (strong, nonatomic) IBOutlet UIButton *placesButton;
@property (strong, nonatomic) IBOutlet UIButton *newsButton;
@property (strong,nonatomic) NSString *zipcode;
@property (strong,nonatomic) LocationGetter *locationGetter;

@end
