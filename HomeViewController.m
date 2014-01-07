//
//  HomeViewController.m
//  Simplr
//
//  Created by Eric on 2/21/13.
//  Copyright (c) 2013 District 7. All rights reserved.
//

#import "HomeViewController.h"
@interface HomeViewController ()
@end
@implementation HomeViewController
@synthesize zipcode,locationGetter,newsButton,placesButton,dealsButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"green_dust_scratch.png"]];
    UINavigationBar *navBar = self.navigationController.navigationBar;
    UIImage *image = [UIImage imageNamed:@"barbackground.png"];
    [navBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    UIImage *logo = [UIImage imageNamed: @"redlogo.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage: logo];
    self.navigationItem.titleView = imageView;
    newsButton.hidden = YES;
}

-(NSString *)getAddressFromLocation:(CLLocation *)newLocation {
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:newLocation
                   completionHandler:^(NSArray *placemarks, NSError *error) {
                       
                       if (error) {
                           return;
                       }
                       if (placemarks && placemarks.count > 0)
                       {
                           CLPlacemark *placemark = placemarks[0];
                           NSDictionary *addressDictionary =
                           placemark.addressDictionary;
                           NSString *zip = [addressDictionary objectForKey:(NSString *)kABPersonAddressZIPKey];
                           zipcode = zip;
                           [locationGetter stopUpdates];
                       }
                   }];
    return zipcode;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
-(void)viewDidAppear:(BOOL)animated{
}
@end
