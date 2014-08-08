//
//  TextViewController.m
//  ThredditCamera
//
//  Created by trineroks on 8/3/14.
//  Copyright (c) 2014 trineroks. All rights reserved.
//

#import "TextViewController.h"

@interface TextViewController ()

@end

@implementation TextViewController

-(id)initWithImage:(UIImage*)p_image
{
    if (self = [super init])
    {
        image = p_image;
        self.imageView.image = image;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
