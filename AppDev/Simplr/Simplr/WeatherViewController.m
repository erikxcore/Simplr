//
//  WeatherViewController.m
//  Simplr
//
//  Created by Eric on 2/21/13.
//  Copyright (c) 2013 District 7. All rights reserved.
//

#import "WeatherViewController.h"
#import "ICB_WeatherConditions.h"
#import "LocationGetter.h"
#import "MapKit/MapKit.h"

@interface WeatherViewController ()

@end

@implementation WeatherViewController

@synthesize currentTempLabel,locationLabel,refreshButton;

-(void)updateUI:(ICB_WeatherConditions *)weather{
    
}

- (IBAction)refreshButton:(id)sender {
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"green_dust_scratch.png"]];

        // Do this in the background so we don't lock up the UI.
        [self performSelectorInBackground:@selector(showWeatherFor:) withObject:@"97217"];

    
}

- (void)showWeatherFor:(NSString *)query
{
    
    ICB_WeatherConditions *weather = [[ICB_WeatherConditions alloc] initWithQuery:query];
    
    [currentTempLabel setText:[NSString stringWithFormat:@"%d", weather.currentTemp]];
    [self.locationLabel setText:weather.location];
    
}

#pragma mark MKReverseGeocoder Delegate Methods
- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFindPlacemark:(MKPlacemark *)placemark
{
    [self performSelectorInBackground:@selector(showWeatherFor:) withObject:[placemark.addressDictionary objectForKey:@"ZIP"]];
}

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFailWithError:(NSError *)error
{
    NSLog(@"reverseGeocoder:%@ didFailWithError:%@", geocoder, error);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
