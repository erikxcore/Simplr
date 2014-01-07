//
//  MirrorViewController.h
//  Simplr
//
//  Created by Eric on 2/21/13.
//  Copyright (c) 2013 District 7. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>


@interface MirrorViewController  : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    IBOutlet UIView *vImagePreview;
    AVCaptureDevice *device;
    AVCaptureSession *session;
    AVCaptureVideoPreviewLayer *captureVideoPreviewLayer;
    BOOL toggle;
    AVCaptureDeviceInput *input;
    BOOL newMedia;
    UIImagePickerController *imagePicker;
    UIImageView *imageView;
}
@property(nonatomic, retain) IBOutlet UIView *vImagePreview;
@property (nonatomic, retain) IBOutlet UIImageView *imageView;

@end
