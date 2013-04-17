//
//  MTZSlideToReveal.m
//  Slide to Reveal
//
//  Created by Matt on 4/14/13.
//  Copyright (c) 2013 Matt Zanchelli. All rights reserved.
//

#import "MTZSlideToReveal.h"
#import <QuartzCore/QuartzCore.h>

@interface MTZSlideToReveal ()

@property (strong, nonatomic) UIImageView *background;
@property (strong, nonatomic) UIImageView *sliderView;
@property (strong, nonatomic) UILabel *dotsLabel;
@property (strong, nonatomic) UILabel *passwordLabel;

@end

@implementation MTZSlideToReveal

- (id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	if (self) {
		// Initalization code
		[self setup];
	}
	return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
		[self setup];
    }
    return self;
}

- (id)init
{
	self = [super init];
	if (self) {
		// Initalization code
		[self setup];
	}
	return self;
}

- (void)setup
{
	[self setOpaque:NO];
	[self setBackgroundColor:[UIColor clearColor]];
	
	_background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Field"]];
	[self addSubview:_background];
	
	_dotsLabel = [[UILabel alloc] initWithFrame:self.bounds];
	[_dotsLabel setFont:[UIFont systemFontOfSize:30.0f]];
	[_dotsLabel setTextAlignment:NSTextAlignmentCenter];
	[_dotsLabel setNumberOfLines:1];
	[_dotsLabel setBaselineAdjustment:UIBaselineAdjustmentAlignCenters];
	[_dotsLabel setAdjustsLetterSpacingToFitWidth:YES];
	[_dotsLabel setAdjustsFontSizeToFitWidth:YES];
	[_dotsLabel setTextColor:[UIColor blackColor]];
	[_dotsLabel setOpaque:NO];
	[_dotsLabel setBackgroundColor:[UIColor clearColor]];
	[self addSubview:_dotsLabel];
	
	CGRect rect = CGRectMake(0, 0, self.bounds.size.width, 40);
	_passwordLabel = [[UILabel alloc] initWithFrame:rect];
	[_passwordLabel setFont:[UIFont systemFontOfSize:30.0f]];
	[_passwordLabel setTextAlignment:NSTextAlignmentCenter];
	[_passwordLabel setNumberOfLines:1];
	[_passwordLabel setBaselineAdjustment:UIBaselineAdjustmentAlignCenters];
	[_passwordLabel setAdjustsLetterSpacingToFitWidth:YES];
	[_passwordLabel setAdjustsFontSizeToFitWidth:YES];
	[_passwordLabel setTextColor:[UIColor blackColor]];
	[_passwordLabel setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Field"]]];
	[_passwordLabel setAlpha:0.0f];
	[self addSubview:_passwordLabel];
	
	_sliderView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Slider"]];
	[_sliderView setHidden:YES];
	[_sliderView setAlpha:0.0f];
	[self addSubview:_sliderView];
	
	UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPan:)];
	[self addGestureRecognizer:pan];
	
	UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(didLongPress:)];
	[self addGestureRecognizer:longPress];
}

- (void)setWord:(NSString *)word
{
	_word = word;
	
	[_passwordLabel setText:word];
	
	NSString *lotsOfDots = [[NSString alloc] init];
	for ( NSUInteger i = 0; i<word.length; ++i ) {
		lotsOfDots = [lotsOfDots stringByAppendingString:@"•"];
	}
	[_dotsLabel setText:lotsOfDots];
}

- (void)didLongPress:(id)sender
{
	if ( [sender isKindOfClass:[UIGestureRecognizer class]] ) {
		NSLog(@"%@", sender);
		switch ( [sender state] ) {
			case UIGestureRecognizerStateBegan:
				[self showPopover:sender];
				[self setPopoverCenter:[sender locationOfTouch:0 inView:self]];
				break;
			case UIGestureRecognizerStateEnded:
				[self hidePopover:sender];
				break;
			case UIGestureRecognizerStateChanged:
				[self setPopoverCenter:[sender locationOfTouch:0 inView:self]];
				break;
			default:
				break;
		}
	}
}

- (void)didPan:(id)sender
{
	if ( [sender isKindOfClass:[UIGestureRecognizer class]] ) {
		NSLog(@"%@", sender);
		switch ( [sender state] ) {
			case UIGestureRecognizerStateBegan:
				[self showPopover:sender];
				break;
			case UIGestureRecognizerStateEnded:
				[self hidePopover:sender];
				break;
			case UIGestureRecognizerStateChanged:
				[self setPopoverCenter:[sender locationOfTouch:0 inView:self]];
				break;
			default:
				break;
		}
	}
}

- (void)showPopover:(id)sender
{
	[_sliderView setHidden:NO];
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationBeginsFromCurrentState:YES];
	[UIView setAnimationDuration:0.2f];
	[UIView setAnimationCurve:UIViewAnimationCurveLinear];
	[_sliderView setAlpha:1.0f];
	[_passwordLabel setAlpha:1.0f];
	[UIView commitAnimations];
}

- (void)hidePopover:(id)sender
{
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationBeginsFromCurrentState:YES];
	[UIView setAnimationDuration:0.15f];
	[UIView setAnimationCurve:UIViewAnimationCurveLinear];
	[UIView setAnimationDidStopSelector:@selector(setPopoverHidden:)];
	[_sliderView setAlpha:0.0f];
	[_passwordLabel setAlpha:0.0f];
	[UIView commitAnimations];
}

- (void)setPopoverHidden:(id)sender
{
	[_sliderView setHidden:YES];
}

- (void)setPopoverCenter:(CGPoint)center
{
	CGFloat min = _sliderView.frame.size.width/2;
	CGFloat max = _background.frame.size.width - _sliderView.frame.size.width/2;
	CGFloat y = 1 + _sliderView.frame.size.height/2;
	CGPoint centre = CGPointMake(MAX(MIN(center.x, max), min), y);
	[_sliderView setCenter:centre];
	
	CGRect frame = CGRectMake(_sliderView.frame.origin.x + 7,
							  _sliderView.frame.origin.y + 6,
							  _sliderView.frame.size.width - 13,
							  _sliderView.frame.size.height - 34);
	UIView *mask = [[UIView alloc] initWithFrame:frame];
	[mask setBackgroundColor:[UIColor blackColor]];
	[_passwordLabel layer].mask = [mask layer];
	NSLog(@"%f %f %f %f", _sliderView.frame.origin.x, _sliderView.frame.origin.y, _sliderView.frame.size.width, _sliderView.frame.size.height);
	
#warning when at edges, the shadow goes over the rounded corners
#warning should go to edges? stick to chunks? Not even on left/right
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
