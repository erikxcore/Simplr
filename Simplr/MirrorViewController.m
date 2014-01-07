//
//  MirrorViewController.m
//  Simplr
//
//  Created by Eric on 2/21/13.
//  Copyright (c) 2013 District 7. All rights reserved.
//

#import "MirrorViewController.h"

@interface MirrorViewController () 

@end

@implementation MirrorViewController

@synthesize vImagePreview,imageView;

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
    
    toggle = YES;
    
    self.view.backgroundColor = [UIColor blackColor];
    
    UINavigationBar *navBar = self.navigationController.navigationBar;
    UIImage *image = [UIImage imageNamed:@"barbackground.png"];
    [navBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    UIImage *logo = [UIImage imageNamed: @"redlogo.png"];
    
    UIImageView *logoView = [[UIImageView alloc] initWithImage: logo];
    
    self.navigationItem.titleView = logoView;

    UIBarButtonItem *flipButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Reverse"
                                   style:UIBarButtonItemStyleBordered
                                   target:self
                                   action:@selector(reverse:)];
    self.navigationItem.rightBarButtonItem = flipButton;

    UIBarButtonItem *cameraButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Camera"
                                   style:UIBarButtonItemStyleBordered
                                   target:self
                                   action:@selector(camera:)];
    self.navigationItem.leftBarButtonItem = cameraButton;
    
    self.view.frame = CGRectMake(0, 0,
                        CGRectGetWidth(self.view.bounds),
                        CGRectGetHeight(self.view.bounds));
    
	}

-(IBAction)reverse:(id)sender{
    [session stopRunning];
    [session removeInput:input];

    [captureVideoPreviewLayer setSession:session];

  
    if(toggle == NO){
    device = [self backCamera];
    toggle = YES;
	}else{
    toggle = NO;
    device = [self frontCamera];
    }
    
	NSError *error = nil;
	input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
	if (!input) {
		// Handle the error appropriately.
		NSLog(@"ERROR: trying to open camera: %@", error);
	}
	[session addInput:input];
	
	[session startRunning];

    
}

-(IBAction)camera:(id)sender{
    [session stopRunning];
    [captureVideoPreviewLayer setSession:nil];
    {
        if ([UIImagePickerController isSourceTypeAvailable:
             UIImagePickerControllerSourceTypeCamera])
        {
            imagePicker =
            [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.sourceType =
            UIImagePickerControllerSourceTypeCamera;
            imagePicker.mediaTypes = [NSArray arrayWithObjects:
                                      (NSString *) kUTTypeImage,
                                      nil];
            imagePicker.allowsEditing = NO;
            [self presentViewController:imagePicker animated:YES completion:nil];
            newMedia = YES;
        }
    }
    if(toggle == NO){
        device = [self backCamera];
        toggle = YES;
	}else{
        toggle = NO;
        device = [self frontCamera];
    }
    

}

-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{

    
    NSString *mediaType = [info
                           objectForKey:UIImagePickerControllerMediaType];
    [self dismissViewControllerAnimated:YES completion:nil];
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *image = [info
                          objectForKey:UIImagePickerControllerOriginalImage];
        
        imageView.image = image;
        if (newMedia)
            UIImageWriteToSavedPhotosAlbum(image,
                                           self,
                                           @selector(image:finishedSavingWithError:contextInfo:),
                                           nil);
    }
    else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie])
    {
        // Code here to support video if enabled
    }
}
-(void)image:(UIImage *)image
finishedSavingWithError:(NSError *)error
 contextInfo:(void *)contextInfo
{
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Save failed"
                              message: @"Failed to save image"\
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
    }
}


-(void)viewDidAppear:(BOOL)animated{
    AVCaptureDevice *flashCheck = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    if(flashCheck.torchMode == AVCaptureTorchModeOn){
        [flashCheck lockForConfiguration:nil];
        [flashCheck setTorchMode:AVCaptureTorchModeOff];
        [flashCheck setFlashMode:AVCaptureFlashModeOff];
        [flashCheck unlockForConfiguration];
        flashCheck = NULL;
    }

    vImagePreview = nil;
    
    //----- SHOW LIVE CAMERA PREVIEW -----
	session = [[AVCaptureSession alloc] init];
	session.sessionPreset = AVCaptureSessionPresetHigh;
    
	//CALayer *viewLayer = self.view.layer;
	//NSLog(@"viewLayer = %@", viewLayer);
	
	captureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:session];
		captureVideoPreviewLayer.frame = CGRectMake(0, 0,
                                                CGRectGetWidth(self.view.bounds),
                                                CGRectGetHeight(self.view.bounds));

   captureVideoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;

    captureVideoPreviewLayer.bounds = [UIScreen mainScreen].bounds;

	[self.view.layer addSublayer:captureVideoPreviewLayer];
    
 
    if(toggle == NO){
        device = [self backCamera];
        toggle = YES;
	}else{
        toggle = NO;
        device = [self frontCamera];
    }
    
	NSError *error = nil;
	input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
	if (!input) {
		// Handle the error appropriately.
		NSLog(@"ERROR: trying to open camera: %@", error);
	}
	[session addInput:input];
	
	[session startRunning];

}

- (AVCaptureDevice *)frontCamera {
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *camera in devices) {
        if ([camera position] == AVCaptureDevicePositionFront) {
            return camera;
        }
    }
    return nil;
}

- (AVCaptureDevice *)backCamera {
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *camera in devices) {
        if ([camera position] == AVCaptureDevicePositionBack) {
            return camera;
        }
    }
    return nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
