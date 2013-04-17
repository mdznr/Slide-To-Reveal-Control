//
//  MTZViewController.m
//  Slide to Reveal
//
//  Created by Matt on 4/14/13.
//  Copyright (c) 2013 Matt Zanchelli. All rights reserved.
//

#import "MTZViewController.h"

@interface MTZViewController ()

@end

@implementation MTZViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	_reveal = [[MTZSlideToReveal alloc] initWithFrame:CGRectMake(20,162,280,49)];
	[_reveal setWord:@"29bmOjgy9OKWeNkVgy!#KWeN"];
	[self.view addSubview:_reveal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
