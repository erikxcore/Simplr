//
//  CalculatorViewController.h
//  Simplr
//
//  Created by Eric on 2/21/13.
//  Copyright (c) 2013 District 7. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QBFlatButton.h"

@interface CalculatorViewController : UIViewController 
{

}

@property (strong,nonatomic) NSString *tipAmount;
@property (strong, nonatomic) IBOutlet UITextField *billAmount;
@property (strong, nonatomic) IBOutlet UILabel *resultsLabel;
@property (strong,nonatomic) IBOutlet QBFlatButton *clearButton;
@property (strong,nonatomic) IBOutlet QBFlatButton *btn1;
@property (strong,nonatomic) IBOutlet QBFlatButton *btn2;
@property (strong,nonatomic) IBOutlet QBFlatButton *btn3;
@property (strong,nonatomic) IBOutlet QBFlatButton *btn4;


- (IBAction)clearTip:(id)sender;
-(void)validateTextFields:(id)sender;

@end
