//
//  ViewController.h
//  ThredditCamera
//
//  Created by trineroks on 8/2/14.
//  Copyright (c) 2014 trineroks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreLocation/CoreLocation.h>
#import "TextViewController.h"



@interface ViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *imageView;


@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, readwrite) CLLocation *location;

- (IBAction)cameraButtonClicked:(id)sender;
- (IBAction)retrievePhoto:(UIButton *)sender;

@end
