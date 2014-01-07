//
//  PlacesViewController.m
//  Simplr
//
//  Created by Eric on 4/2/13.
//  Copyright (c) 2013 District 7. All rights reserved.
//

#import "PlacesViewController.h"
#import "FindPlaces.h"
#import "PlacesCell.h"
#import "DetailsViewController.h"
#import "RXMLElement.h"
@interface PlacesViewController ()
@end
@implementation PlacesViewController
@synthesize locationGetter,zipcode,refreshButton,errorLabel,places,table;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}
-(IBAction)manual:(id)sender{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Zipcode Required!" message:@"Enter a manual zipcode." delegate:self cancelButtonTitle:@"Done" otherButtonTitles:nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField * alertTextField = [alert textFieldAtIndex:0];
    alertTextField.keyboardType = UIKeyboardTypeNumberPad;
    alertTextField.placeholder = @"07405";
    [alert show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSString *zip = [alertView textFieldAtIndex:0].text;
    BOOL valid;
    NSCharacterSet *alphaNums = [NSCharacterSet alphanumericCharacterSet];
    NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:zip];
    valid = [alphaNums isSupersetOfSet:inStringSet];
    if (!valid){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Invalid zip" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        alert.alertViewStyle = UIAlertViewStyleDefault;
        [alert show];
    }else if((zip.length > 5) || zip.length < 5){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Zip too long or too short!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        alert.alertViewStyle = UIAlertViewStyleDefault;
        [alert show];
    }else{
        [self performSelectorInBackground:@selector(showPlacesFor:) withObject:zip];
        [self updateUI:NO];
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"green_dust_scratch.png"]];
    UINavigationBar *navBar = self.navigationController.navigationBar;
    UIImage *image = [UIImage imageNamed:@"barbackground.png"];
    [navBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    UIImage *logo = [UIImage imageNamed: @"redlogo.png"];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage: logo];
    self.navigationItem.titleView = imageView;
    locationAllowed = NO;
    if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized){
        locationAllowed = YES;
    };
    locationGetter = [[LocationGetter alloc] init];
    locationGetter.delegate = self;
    [locationGetter startUpdates];
    CLLocation *location = [locationGetter location];
    [self getAddressFromLocation:location];
    table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 400) style:UITableViewStylePlain];
    table.frame = CGRectMake(0, 0, 320, 400);
    table.backgroundColor = [[UIColor alloc] initWithRed:0 green:0 blue:0 alpha:0.0];
    [table setDelegate:self];
    [table setDataSource:self];
    [self updateUI:YES];
    
}
- (void)showPlacesFor:(NSString *)query
{
    FindPlaces *PlaceFind= [[FindPlaces alloc] initWithQuery:query];
    places = PlaceFind.places;
    [table reloadData];
    [self.view addSubview:table];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *placesTableIdentifier = @"PlacesCell";
    PlacesCell *cell = (PlacesCell *)[tableView dequeueReusableCellWithIdentifier:placesTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PlacesCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.name.text = [[places objectAtIndex:indexPath.row]child:@"name"].text;
    if([[places objectAtIndex:indexPath.row]child:@"rating"] == nil){
        cell.rating.text = @"N/A";
    }else{
    cell.rating.text = [[places objectAtIndex:indexPath.row]child:@"rating"].text;
    }cell.neighborhood.text =[[places objectAtIndex:indexPath.row]child:@"neighborhood"].text;
    cell.street.text = [[[places objectAtIndex:indexPath.row]child:@"name"]child:@"street"].text;
    cell.city.text =  [[[places objectAtIndex:indexPath.row]child:@"name"]child:@"city"].text;
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [places count];
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
                           [self performSelectorInBackground:@selector(showPlacesFor:) withObject:zip];
                           [locationGetter stopUpdates];
                           [self updateUI:NO];
                       }
                       
                   }];
    
    return zipcode;
}

-(void)updateUI:(BOOL)toggle{
    if(toggle){
        UIActivityIndicatorView  *av = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        av.frame=CGRectMake(145, 150, 25, 25);
        av.tag  = 1;
        [self.view addSubview:av];
        [av startAnimating];
    }else{
        UIActivityIndicatorView *tmpimg = (UIActivityIndicatorView *)[self.view viewWithTag:1];
        [tmpimg removeFromSuperview];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *link = [[NSString alloc]initWithString:[[places objectAtIndex:indexPath.row]child:@"profile"].text];
    NSLog(@"%@",link);
    
    DetailsViewController *detail = [[DetailsViewController alloc] initWithNibName:nil bundle:nil];
    detail.url = [[NSURL alloc]initWithString:link];
    detail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detail animated:YES];
    [table deselectRowAtIndexPath:indexPath animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
