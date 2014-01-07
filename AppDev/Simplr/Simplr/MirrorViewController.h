//
//  MirrorViewController.h
//  Simplr
//
//  Created by Eric on 2/21/13.
//  Copyright (c) 2013 District 7. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface MirrorViewController : UIViewController
{
    UIImageView *imageView;
    BOOL newMedia;
    BOOL mirrorOn;
}
@property (nonatomic, retain) IBOutlet UIImageView *imageView;
- (IBAction)toggleMirror:(id)sender;

@end
