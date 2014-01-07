//
//  DealsViewController.h
//  Simplr
//
//  Created by Eric on 4/2/13.
//  Copyright (c) 2013 District 7. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "FindDeals.h"
#import "LocationGetter.h"
#import "QBFlatButton.h"

@interface DealsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
      BOOL locationAllowed;
}


@property (strong,nonatomic) LocationGetter *locationGetter;
@property (strong, nonatomic) NSString *zipcode;
@property (strong,nonatomic) IBOutlet QBFlatButton *refreshButton;
@property (strong,nonatomic) IBOutlet UILabel *errorLabel;
@property (strong, nonatomic) NSMutableArray *deals;
@property (strong, nonatomic) UITableView *table;


//- (IBAction)refreshButton:(id)sender;


@end
