//
//  ViewController.m
//  ThredditCamera
//
//  Created by trineroks on 8/2/14.
//  Copyright (c) 2014 trineroks. All rights reserved.
//

#import "ViewController.h"
#import <Parse/Parse.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self locationManager] startUpdatingLocation];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//This method is called when the "Camera" button is clicked on the ViewController
- (IBAction)cameraButtonClicked:(id)sender {
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Camera not available!" message:@"The Camera is missing!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alertView show];
    }
    else
    {
        UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
        ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
        ipc.allowsEditing = false;
        ipc.delegate = self;
        _location = _locationManager.location;
        //When the Camera is detected, the iOS Camera viewcontroller is called. Refer to "imagePickerController"
        [self.navigationController presentViewController:ipc animated:true completion:nil];
    }
}

//This method is called when the "Retrieve" button is clicked on the ViewController
- (IBAction)retrievePhoto:(UIButton *)sender
{
    PFQuery *query = [PFQuery queryWithClassName:@"UserPhoto"];
    PFUser *user = [PFUser currentUser];
    [query whereKey:@"user" equalTo:user];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        //NSMutableArray *newObjectIDArray = [NSMutableArray array];
       // NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
        PFObject *filler = [objects objectAtIndex:objects.count-1];
        PFFile *theImage = [filler objectForKey:@"imageFile"];
        NSData *imageData = [theImage getData];
        UIImage *image = [UIImage imageWithData:imageData];
        [self displayImage:image];
    }];
}

#pragma mark ImagePicker Delegate
//This method is called when the Camera clicked button goes through successfully
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self dismissViewControllerAnimated:true completion:nil];

    
    //Camera input ends here, this is when the user clicks on "use photo"
    NSData *jpegImage = UIImageJPEGRepresentation(image, 0.05f);
    
    PFFile *imageFile = [PFFile fileWithName:@"Image.jpg" data:jpegImage];
    [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error)
        {
            PFObject *userPhoto = [PFObject objectWithClassName:@"UserPhoto"];
            [userPhoto setObject:imageFile forKey:@"imageFile"];
            
            userPhoto.ACL = [PFACL ACLWithUser:[PFUser currentUser]];
            PFUser *user = [PFUser currentUser];
            [userPhoto setObject:user forKey:@"user"];
            CLLocationCoordinate2D coordinate = [_location coordinate];
            PFGeoPoint *geoPoint = [PFGeoPoint geoPointWithLatitude:coordinate.latitude longitude:coordinate.longitude];
            //PFObject *locationObject = [PFObject objectWithClassName:@"Location"];
            [userPhoto setObject:geoPoint forKey:@"Location"];
            [userPhoto saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (error)
                {
                    NSLog(@"Unable to upload!");
                }
            }];
        }
    }];
    
    [self displayImage:image];
    //self.imageView.image = image;
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:true completion:nil];
}

-(void)displayImage:(UIImage *)image
{
    self.imageView.image = image;
}

-(CLLocationManager *)locationManager
{
    if (_locationManager != nil)
    {
        return _locationManager;
    }
    _locationManager = [[CLLocationManager alloc] init];
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    [_locationManager setDelegate:self];
    //[_locationManager setPurpose:@"Current Location"];
    
    return _locationManager;
}

@end
