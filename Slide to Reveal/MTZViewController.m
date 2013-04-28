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
	
	UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[button setFrame:CGRectMake(20, 162, 280, 49)];
	[button setTitle:@"Okay" forState:UIControlStateNormal];
	[self.view addSubview:button];
	
	UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(didGestureOnButton:)];
	[button addGestureRecognizer:longPressGesture];
	UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didGestureOnButton:)];
	[button addGestureRecognizer:panGesture];
	
	_reveal = [[MTZSlideToReveal alloc] initWithFrame:CGRectMake(20,162,280,49)];
	[_reveal setWord:@"29bmOjgy9OKW"]; // 12
	[_reveal setWord:@"29bmOjgy9OKWeNkV"]; // 16
	[_reveal setWord:@"29bmOjgy9OKWeNkVgy!#"]; // 20
	[_reveal setWord:@"29bmOjgy9OKWeNkVgy!#KWeN"]; // 24
	[self.view addSubview:_reveal];
	[_reveal setHidden:YES];
}

- (void)didGestureOnButton:(id)sender
{
	if ( [sender isKindOfClass:[UIGestureRecognizer class]] ) {
		switch ( [sender state] ) {
			case UIGestureRecognizerStateBegan:
				[_reveal setHidden:NO];
				break;
			case UIGestureRecognizerStateEnded:
				[_reveal setHidden:YES];
				break;
			case UIGestureRecognizerStateChanged:
				[_reveal setHidden:NO];
				break;
			default:
				break;
		}
		[_reveal didGesture:sender];
	}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
