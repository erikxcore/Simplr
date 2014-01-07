//
//  CalculatorViewController.m
//  Simplr
//
//  Created by Eric on 2/21/13.
//  Copyright (c) 2013 District 7. All rights reserved.
//

#import "CalculatorViewController.h"

@interface CalculatorViewController ()

@end

@implementation CalculatorViewController

@synthesize billAmount;
@synthesize tipPercentage;
@synthesize submitButton;
@synthesize clearButton;
@synthesize resultsLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
     //Custom initialization here
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"green_dust_scratch.png"]];
    clearButton.hidden = TRUE;
    submitButton.enabled = FALSE;
    billAmount.text=@"";
    tipPercentage.text=@"";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [billAmount resignFirstResponder];
    [tipPercentage resignFirstResponder];
    [self validateTextFields:self];
}

- (IBAction)clearTip:(id)sender {
    billAmount.text=@"";
    tipPercentage.text=@"";
    
    clearButton.enabled = NO;
    clearButton.hidden = TRUE;
    submitButton.enabled = FALSE;
    resultsLabel.text=@"";
}

- (IBAction)calculateTip:(id)sender {
    [billAmount resignFirstResponder];
    [tipPercentage resignFirstResponder];
    NSString *bill = [billAmount text];
    NSString *tip = [tipPercentage text];
    
    float billValue = [bill floatValue];
    float tipValue = [tip floatValue];
    tipValue = tipValue / 100;
    float finalTip = billValue * tipValue;
    
    NSString *result = [NSString stringWithFormat:@"Your tip should be: %0.2f",finalTip];
    
    [resultsLabel setText:result];
    clearButton.enabled = YES;
    clearButton.hidden = FALSE;
}

-(void)validateTextFields:(id)sender
{

    if ((billAmount.text.length  > 0) && (tipPercentage.text.length > 0)) {
        submitButton.enabled = YES;
    }
    else {
        submitButton.enabled = NO;
    }
}
@end
