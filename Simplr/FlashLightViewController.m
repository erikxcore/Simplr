//
//  FlashLightViewController.m
//  Simplr
//
//  Created by Eric on 2/21/13.
//  Copyright (c) 2013 District 7. All rights reserved.
//

#import "FlashLightViewController.h"

@interface FlashLightViewController ()

@end

@implementation FlashLightViewController

@synthesize AVSession,flashLightButton;

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
    device  = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    UILabel *sliderText = [[UILabel alloc]init];
    sliderText.frame = CGRectMake(120,240,100,20);
    sliderText.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.0];
    [sliderText setText:@"Strength:"];
    sliderText.textColor = [UIColor whiteColor];
    UISlider *slider=[[UISlider alloc]initWithFrame:CGRectMake(100, 260, 100, 50)];//240, 0, 100, 50: 50, 35, 250, 30
    slider.minimumValue=0.1;
    slider.maximumValue=1;
    slider.value = 1;
    [slider setMinimumTrackTintColor:[UIColor colorWithRed:.1 green:.7 blue:0 alpha:1.0]];
    [slider setMaximumTrackTintColor:[UIColor blackColor]];
    [slider addTarget:self action:@selector(brightnesssliderMove:) forControlEvents:UIControlEventTouchUpInside];
    [slider addTarget:self action:@selector(brightnesssliderMove:) forControlEvents:UIControlEventTouchUpOutside];

    [self.view addSubview:sliderText];
    [self.view addSubview:slider];

}




-(void)brightnesssliderMove:(UISlider *)sender
{

    [device lockForConfiguration:nil];
    if(device.torchMode == AVCaptureTorchModeOff){
        device.torchMode = AVCaptureTorchModeOn;
    }
    flashlightOn = YES;
    [flashLightButton setImage:[UIImage imageNamed:@"flashon@2x.png"] forState:UIControlStateNormal];
    [device setTorchModeOnWithLevel:[sender value] error:NULL];
    
    [device unlockForConfiguration];
    // [ViewController viewAlpha:brightValue];
}

-(void)viewAlpha:(NSString*)string
{
    [UIScreen mainScreen].brightness = [string floatValue];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)toggleLight:(id)sender {
    if(flashlightOn == NO){
        flashlightOn = YES;
        [flashLightButton setImage:[UIImage imageNamed:@"flashon@2x.png"] forState:UIControlStateNormal];
        
    }else{
        flashlightOn = NO;
            [flashLightButton setImage:[UIImage imageNamed:@"flashoff@2x.png"] forState:UIControlStateNormal];
    }
    
    [self toggleFlashLight];
}

-(void)toggleFlashLight{

    
    if(device.torchMode == AVCaptureTorchModeOff){
        [device lockForConfiguration:nil];
        [device setTorchMode:AVCaptureTorchModeOn];
        [device setFlashMode:AVCaptureFlashModeOn];
        [device unlockForConfiguration];
    }else{
        [device lockForConfiguration:nil];
        [device setTorchMode:AVCaptureTorchModeOff];
        [device setFlashMode:AVCaptureFlashModeOff];
        [device unlockForConfiguration];
    }
    
}

@end
