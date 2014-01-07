//
//  DetailsViewController.m
//  Simplr
//
//  Created by Eric on 4/3/13.
//  Copyright (c) 2013 District 7. All rights reserved.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController


@synthesize url;

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

    //webView.delegate = self;
    UIWebView *webView = [[UIWebView alloc]init];
    webView.delegate = self;
    webView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds),
                               CGRectGetHeight(self.view.bounds));
   [webView setOpaque:NO];
    webView.backgroundColor = [UIColor clearColor];
    
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [webView loadRequest:requestObj];
  
 
    [self.view addSubview:webView];
    [self updateUI:YES];
   
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


-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [self updateUI:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
