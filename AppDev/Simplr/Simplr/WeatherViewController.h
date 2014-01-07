//
//  WeatherViewController.h
//  Simplr
//
//  Created by Eric on 2/21/13.
//  Copyright (c) 2013 District 7. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "ICB_WeatherConditions.h"

@interface WeatherViewController : UIViewController
{
    NSString *location;
    NSInteger currentTemp;
}
@property (strong, nonatomic) IBOutlet UILabel *currentTempLabel;
@property (strong, nonatomic) IBOutlet UILabel *locationLabel;
@property (strong, nonatomic) IBOutlet UIButton *refreshButton;

- (void)updateUI:(ICB_WeatherConditions *)weather;
- (IBAction)refreshButton:(id)sender;

@end
