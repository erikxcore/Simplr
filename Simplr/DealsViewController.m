//
//  DealsViewController.m
//  Simplr
//
//  Created by Eric on 4/2/13.
//  Copyright (c) 2013 District 7. All rights reserved.
//

#import "DealsViewController.h"
#import "FindDeals.h"
#import "DealsCell.h"
#import "RXMLElement.h"
#import "DetailsViewController.h"
#import "SDImageCache.h"
#import "UIImageView+WebCache.h"

@interface DealsViewController ()

@end

@implementation DealsViewController

@synthesize locationGetter,zipcode,refreshButton,errorLabel,deals,table;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
        
        [self performSelectorInBackground:@selector(showDealsFor:) withObject:zip];
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
  //  UIBarButtonItem *flipButton = [[UIBarButtonItem alloc]
  //                                 initWithTitle:@"Manual"
 //                                  style:UIBarButtonItemStyleBordered
  //                                 target:self
  //                                 action:@selector(manual:)];
 //   self.navigationItem.rightBarButtonItem = flipButton;
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
 
- (void)showDealsFor:(NSString *)query
{
    
    FindDeals *DealFind= [[FindDeals alloc] initWithQuery:query];
    
    deals = DealFind.deals;
    
    [table reloadData];
    
    [self.view addSubview:table];
    }

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *dealsTableIdentifier = @"DealsCell";
    
    DealsCell *cell = (DealsCell *)[tableView dequeueReusableCellWithIdentifier:dealsTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DealsTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.nameLabel.text = [[deals objectAtIndex:indexPath.row]child:@"title"].text;
    cell.blurbLabel.text = [[deals objectAtIndex:indexPath.row]child:@"description"].text;
    
    NSURL *url = [[NSURL alloc]initWithString:[[deals objectAtIndex:indexPath.row]child:@"image_thumb"].text];
   // NSData *currentData = [NSData dataWithContentsOfURL:url];
    [cell.thumbnailImageView setImageWithURL:url
                   placeholderImage:nil];
   // cell.thumbnailImageView.image = [[UIImage alloc]initWithData:currentData];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [deals count];
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
                           [self performSelectorInBackground:@selector(showDealsFor:) withObject:zip];
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
    NSString *link = [[NSString alloc]initWithString:[[deals objectAtIndex:indexPath.row]child:@"link"].text];
    //NSLog(@"%@",link);
    
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
