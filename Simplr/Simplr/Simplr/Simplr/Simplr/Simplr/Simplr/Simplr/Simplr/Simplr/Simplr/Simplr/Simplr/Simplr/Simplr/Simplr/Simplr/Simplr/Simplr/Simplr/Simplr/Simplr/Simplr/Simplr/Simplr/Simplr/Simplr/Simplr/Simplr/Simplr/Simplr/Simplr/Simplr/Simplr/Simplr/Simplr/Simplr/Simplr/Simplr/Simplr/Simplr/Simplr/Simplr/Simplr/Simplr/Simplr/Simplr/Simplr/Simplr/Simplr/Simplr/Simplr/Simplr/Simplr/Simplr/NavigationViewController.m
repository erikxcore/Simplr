//
//  NavigationViewController.m
//  Simplr
//
//  Created by Eric on 2/21/13.
//  Copyright (c) 2013 District 7. All rights reserved.
//

#import "NavigationViewController.h"

@interface NavigationViewController ()

@end

@implementation NavigationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tabBarController.tabBar.tintColor = [[UIColor alloc]initWithRed:0.00 green:0.62 blue:0.93 alpha:1.0];
        [self.tabBarController setSelectedIndex:2];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tabBarController.tabBar.tintColor = [[UIColor alloc]initWithRed:0.00 green:0.62 blue:0.93 alpha:1.0];
    [self.tabBarController setSelectedIndex:2];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
