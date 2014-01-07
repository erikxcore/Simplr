//
//  FlashLightViewController.h
//  Simplr
//
//  Created by Eric on 2/21/13.
//  Copyright (c) 2013 District 7. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface FlashLightViewController : UIViewController
{
AVCaptureSession *AVSession;
BOOL flashlightOn;
    AVCaptureDevice *device;
}

- (IBAction)toggleLight:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *flashLightButton;
@property (nonatomic, retain) AVCaptureSession *AVSession;
@end
