//
//  CalculatorViewController.m
//  Simplr
//
//  Created by Eric on 2/21/13.
//  Copyright (c) 2013 District 7. All rights reserved.
//

#import "CalculatorViewController.h"
#import "QBFlatButton.h"
#import <QuartzCore/QuartzCore.h>

@interface CalculatorViewController ()

@end

@implementation CalculatorViewController

@synthesize tipAmount;
@synthesize billAmount;
@synthesize clearButton;
@synthesize resultsLabel;
@synthesize btn1,btn2,btn3,btn4;



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
    UINavigationBar *navBar = self.navigationController.navigationBar;
    UIImage *image = [UIImage imageNamed:@"barbackground.png"];
    [navBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    UIImage *logo = [UIImage imageNamed: @"redlogo.png"];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage: logo];
    
    self.navigationItem.titleView = imageView;
    
    
    btn1 = [QBFlatButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(55, 100, 100, 50);
    

    btn1.faceColor = [UIColor colorWithWhite:0.75 alpha:1.0];
    btn1.sideColor = [UIColor colorWithWhite:0.55 alpha:1.0];

    
    btn1.radius = 6.0;
    btn1.margin = 4.0;
    btn1.depth = 3.0;
    
    btn1.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateDisabled];
    [btn1 setTitle:@"10%" forState:UIControlStateNormal];
    
    [self.view addSubview:btn1];

    [btn1 addTarget:self action:@selector(btn1:) forControlEvents:UIControlEventTouchUpInside];
    
    btn2 = [QBFlatButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(165, 100, 100, 50);
    
    btn2.faceColor = [UIColor colorWithWhite:0.75 alpha:1.0];
    btn2.sideColor = [UIColor colorWithWhite:0.55 alpha:1.0];

    btn2.radius = 6.0;
    btn2.margin = 4.0;
    btn2.depth = 3.0;
    
    btn2.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateDisabled];
    [btn2 setTitle:@"15%" forState:UIControlStateNormal];
    
    [self.view addSubview:btn2];
    
    [btn2 addTarget:self action:@selector(btn2:) forControlEvents:UIControlEventTouchUpInside];

    btn3 = [QBFlatButton buttonWithType:UIButtonTypeCustom];
    btn3.frame = CGRectMake(55, 160, 100, 50);
    
    btn3.faceColor = [UIColor colorWithWhite:0.75 alpha:1.0];
    btn3.sideColor = [UIColor colorWithWhite:0.55 alpha:1.0];

    
    btn3.radius = 6.0;
    btn3.margin = 4.0;
    btn3.depth = 3.0;
    
    btn3.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [btn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateDisabled];
    [btn3 setTitle:@"20%" forState:UIControlStateNormal];
    
    [self.view addSubview:btn3];
    
    [btn3 addTarget:self action:@selector(btn3:) forControlEvents:UIControlEventTouchUpInside];
    
    btn4 = [QBFlatButton buttonWithType:UIButtonTypeCustom];
    btn4.frame = CGRectMake(165, 160, 100, 50);
    
    btn4.faceColor = [UIColor colorWithWhite:0.75 alpha:1.0];
    btn4.sideColor = [UIColor colorWithWhite:0.55 alpha:1.0];
    
    btn4.radius = 6.0;
    btn4.margin = 4.0;
    btn4.depth = 3.0;
    
    btn4.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [btn4 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn4 setTitleColor:[UIColor blackColor] forState:UIControlStateDisabled];
    [btn4 setTitle:@"Manual" forState:UIControlStateNormal];
    
    [self.view addSubview:btn4];
    
    [btn4 addTarget:self action:@selector(btn4:) forControlEvents:UIControlEventTouchUpInside];

    clearButton = [QBFlatButton buttonWithType:UIButtonTypeCustom];
    clearButton.frame = CGRectMake(10,330,75,50);
    
    clearButton.faceColor = [UIColor colorWithRed:255/255.0f green:152/255.0f blue:11/255.0f alpha:1.0f];
    clearButton.sideColor = [UIColor colorWithRed:255/255.0f green:97/255.0f blue:0/255.0f alpha:1.0f];
    
    clearButton.radius = 6.0;
    clearButton.margin = 4.0;
    clearButton.depth = 3.0;
    
    clearButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [clearButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [clearButton setTitle:@"Clear" forState:UIControlStateNormal];
    
    [self.view addSubview:clearButton];
    
    [clearButton addTarget:self action:@selector(clearTip:) forControlEvents:UIControlEventTouchUpInside];
    
    [billAmount addTarget:self action:@selector(validateTextFields:) forControlEvents:UIControlEventEditingChanged];

    btn1.enabled = FALSE;
    btn2.enabled = FALSE;
    btn3.enabled = FALSE;
    btn4.enabled = FALSE;

    
    clearButton.hidden = TRUE;
    clearButton.enabled = FALSE;
    billAmount.text=@"";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [billAmount resignFirstResponder];
    [self validateTextFields:self];
}


- (IBAction)clearTip:(id)sender {
    billAmount.text=@"";
    clearButton.enabled = NO;
    btn1.enabled = FALSE;
    btn2.enabled = FALSE;
    btn3.enabled = FALSE;
    btn4.enabled = FALSE;
    btn1.faceColor = [UIColor colorWithWhite:0.75 alpha:1.0];
    btn1.sideColor = [UIColor colorWithWhite:0.55 alpha:1.0];
    btn2.faceColor = [UIColor colorWithWhite:0.75 alpha:1.0];
    btn2.sideColor = [UIColor colorWithWhite:0.55 alpha:1.0];
    btn3.faceColor = [UIColor colorWithWhite:0.75 alpha:1.0];
    btn3.sideColor = [UIColor colorWithWhite:0.55 alpha:1.0];
    btn4.faceColor = [UIColor colorWithWhite:0.75 alpha:1.0];
    btn4.sideColor = [UIColor colorWithWhite:0.55 alpha:1.0];
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFade;
    animation.duration = 0.4;
    [clearButton.layer addAnimation:animation forKey:nil];
    [resultsLabel.layer addAnimation:animation forKey:nil];
    
    clearButton.hidden = TRUE;
    resultsLabel.text=@"";
}

-(IBAction)btn1:(id)sender{
    [billAmount resignFirstResponder];
    NSString *bill = [billAmount text];
    
    float billValue = [bill floatValue];
    float tipValue = 10.00;
    tipValue = tipValue / 100;
    float finalTip = billValue * tipValue;
    
    NSString *result = [NSString stringWithFormat:@"TIP TOTAL :  $%0.2f",finalTip];
    
    [resultsLabel setText:result];
    clearButton.enabled = YES;
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFromLeft;
    animation.duration = 0.4;
    [clearButton.layer addAnimation:animation forKey:nil];
    [resultsLabel.layer addAnimation:animation forKey:nil];
    clearButton.hidden = FALSE;

}


-(IBAction)btn2:(id)sender{
    [billAmount resignFirstResponder];
    NSString *bill = [billAmount text];
    
    float billValue = [bill floatValue];
    float tipValue = 15.00;
    tipValue = tipValue / 100;
    float finalTip = billValue * tipValue;
    
    NSString *result = [NSString stringWithFormat:@"TIP TOTAL :  $%0.2f",finalTip];
    
    [resultsLabel setText:result];
    clearButton.enabled = YES;
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFromLeft;
    animation.duration = 0.4;
    [clearButton.layer addAnimation:animation forKey:nil];
    [resultsLabel.layer addAnimation:animation forKey:nil];
    clearButton.hidden = FALSE;
    
}

-(IBAction)btn3:(id)sender{
    [billAmount resignFirstResponder];
    NSString *bill = [billAmount text];
    
    float billValue = [bill floatValue];
    float tipValue = 20.00;
    tipValue = tipValue / 100;
    float finalTip = billValue * tipValue;
    
    NSString *result = [NSString stringWithFormat:@"TIP TOTAL :  $%0.2f",finalTip];
    
    [resultsLabel setText:result];
    clearButton.enabled = YES;
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFromLeft;
    animation.duration = 0.4;
    [clearButton.layer addAnimation:animation forKey:nil];
    [resultsLabel.layer addAnimation:animation forKey:nil];
    clearButton.hidden = FALSE;
    
}
-(IBAction)btn4:(id)sender{
    [billAmount resignFirstResponder];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Tip Required" message:@"Enter a % to tip" delegate:self cancelButtonTitle:@"Done" otherButtonTitles:nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    
    UITextField * alertTextField = [alert textFieldAtIndex:0];
    alertTextField.keyboardType = UIKeyboardTypeDecimalPad;
    alertTextField.placeholder = @"15%";
    [alert show];
    
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSString *tip = [alertView textFieldAtIndex:0].text;
    [self setTipAmount:tip];
    NSString *bill = [billAmount text];
    
    
    float tipValue = 0;
    float billValue = [bill floatValue];
    tipValue = [[self tipAmount ]floatValue] / 100;
    float finalTip = billValue * tipValue;
    
    NSString *result = [NSString stringWithFormat:@"TIP TOTAL :  $%0.2f",finalTip];
    
    [self setTipAmount:@""];
    [resultsLabel setText:result];
    clearButton.enabled = YES;
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFromLeft;
    animation.duration = 0.4;
    [clearButton.layer addAnimation:animation forKey:nil];
    [resultsLabel.layer addAnimation:animation forKey:nil];
    clearButton.hidden = FALSE;

}

-(void)validateTextFields:(id)sender
{

    if(billAmount.text.length  > 0){
        btn1.enabled = YES;
        btn2.enabled = YES;
        btn3.enabled = YES;
        btn4.enabled = YES;
        btn1.faceColor = [UIColor colorWithRed:0.333 green:0.631 blue:0.851 alpha:1.0];
        btn1.sideColor = [UIColor colorWithRed:0.310 green:0.498 blue:0.702 alpha:1.0];
        btn2.faceColor = [UIColor colorWithRed:0.333 green:0.631 blue:0.851 alpha:1.0];
        btn2.sideColor = [UIColor colorWithRed:0.310 green:0.498 blue:0.702 alpha:1.0];
        btn3.faceColor = [UIColor colorWithRed:0.333 green:0.631 blue:0.851 alpha:1.0];
        btn3.sideColor = [UIColor colorWithRed:0.310 green:0.498 blue:0.702 alpha:1.0];
        btn4.faceColor = [UIColor colorWithRed:0.333 green:0.631 blue:0.851 alpha:1.0];
        btn4.sideColor = [UIColor colorWithRed:0.310 green:0.498 blue:0.702 alpha:1.0];

    }else{
        btn1.enabled = NO;
        btn2.enabled = NO;
        btn3.enabled = NO;
        btn4.enabled = NO;
        btn1.faceColor = [UIColor colorWithWhite:0.75 alpha:1.0];
        btn1.sideColor = [UIColor colorWithWhite:0.55 alpha:1.0];
        btn2.faceColor = [UIColor colorWithWhite:0.75 alpha:1.0];
        btn2.sideColor = [UIColor colorWithWhite:0.55 alpha:1.0];
        btn3.faceColor = [UIColor colorWithWhite:0.75 alpha:1.0];
        btn3.sideColor = [UIColor colorWithWhite:0.55 alpha:1.0];
        btn4.faceColor = [UIColor colorWithWhite:0.75 alpha:1.0];
        btn4.sideColor = [UIColor colorWithWhite:0.55 alpha:1.0];

    }
}

@end
