//
//  TextViewController.h
//  ThredditCamera
//
//  Created by Jason Lee on 8/3/14.
//  Copyright (c) 2014 trineroks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface TextViewController : UIViewController
{
    UIImage *image;
}
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

-(id)initWithImage:(UIImage*)p_image;

@end
