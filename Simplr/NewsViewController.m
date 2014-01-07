//
//  NewsViewController.m
//  Simplr
//
//  Created by Eric on 4/2/13.
//  Copyright (c) 2013 District 7. All rights reserved.
//

#import "NewsViewController.h"
#import "DetailsViewController.h"
#import "FindNews.h"
#import "NewsCell.h"

@interface NewsViewController ()

@end

@implementation NewsViewController

@synthesize locationGetter,zipcode,news,table,errorLabel,refreshButton;

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    //NSString *link = [[NSString alloc]initWithString:[[deals objectAtIndex:indexPath.row]child:@"link"].text];
    //NSLog(@"%@",link);
    /*
    DetailsViewController *detail = [[DetailsViewController alloc] initWithNibName:nil bundle:nil];
    detail.url = [[NSURL alloc]initWithString:link];
    detail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detail animated:YES];
    [table deselectRowAtIndexPath:indexPath animated:YES];
*/
     }



- (void)showDealsFor:(NSString *)query
{
    
   // FindNews *NewsFind= [[FindNews alloc] initWithQuery:query];
    
    //deals = DealFind.deals;
    
    [table reloadData];
    
    [self.view addSubview:table];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *newsTableIdentifier = @"NewsCell";
    
    NewsCell *cell = (NewsCell *)[tableView dequeueReusableCellWithIdentifier:newsTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"NewsTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
   // cell.nameLabel.text = [[deals objectAtIndex:indexPath.row]child:@"title"].text;
   // cell.blurbLabel.text = [[deals objectAtIndex:indexPath.row]child:@"description"].text;
    
  //  NSURL *url = [[NSURL alloc]initWithString:[[deals objectAtIndex:indexPath.row]child:@"image_thumb"].text];
  //  NSData *currentData = [NSData dataWithContentsOfURL:url];
    
   // cell.thumbnailImageView.image = [[UIImage alloc]initWithData:currentData];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}


@end
