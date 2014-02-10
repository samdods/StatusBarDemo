//
//  OverlayViewController.m
//  StatusBarDemo
//
//  Created by Sam Dods on 10/02/2014.
//  Copyright (c) 2014 Sam Dods. All rights reserved.
//

#import "OverlayViewController.h"

@interface OverlayViewController ()
@property (assign, nonatomic) CGFloat containerOffsetYWhenPanBegan;
@end

@implementation OverlayViewController

- (id)init
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.view.layer.cornerRadius = 8;
}

- (void)show
{
  [self setHidden:NO duration:0.6 options:UIViewAnimationOptionCurveEaseInOut];
}

- (IBAction)didTap:(UITapGestureRecognizer *)tapGesture
{
  BOOL shouldOpen = self.window.frame.origin.y > 0;
  [self setHidden:!shouldOpen duration:0.6 options:UIViewAnimationOptionCurveEaseInOut];
}

- (IBAction)didPan:(UIPanGestureRecognizer *)panGesture
{
  CGPoint translation = [panGesture translationInView:self.view];
  CGPoint velocity = [panGesture velocityInView:self.view];
  BOOL shouldOpen = velocity.y < 0;
  switch (panGesture.state) {
    case UIGestureRecognizerStateBegan:
      self.containerOffsetYWhenPanBegan = self.window.frame.origin.y;
      break;
    case UIGestureRecognizerStateChanged: {
      CGRect frame = self.window.bounds;
      frame.origin.y = MAX(0, self.containerOffsetYWhenPanBegan + translation.y);
      self.window.frame = frame;
    } break;
    case UIGestureRecognizerStateEnded:
    case UIGestureRecognizerStateCancelled:
    case UIGestureRecognizerStateFailed: {
      CGFloat targetOffsetY = shouldOpen ? 0 : CGRectGetHeight(self.view.bounds) - 80;
      CGFloat distance = fabsf(CGRectGetMinY(self.window.frame) - targetOffsetY);
      CGFloat speed = fabsf(velocity.y);
      NSTimeInterval duration = distance/speed;
      [self setHidden:!shouldOpen duration:duration options:UIViewAnimationOptionCurveEaseOut];
    } break;
    default:
      break;
  }
}

- (void)setHidden:(BOOL)hidden duration:(NSTimeInterval)duration options:(UIViewAnimationOptions)options
{
  [UIView animateWithDuration:0.6 delay:0 options:options animations:^{
    CGRect frame = self.window.bounds;
    frame.origin.y = !hidden ? 0 : CGRectGetHeight(self.view.bounds) - 80;
    self.window.frame = frame;
  } completion:NULL];
}

- (UIWindow *)window
{
  return self.view.window;
}

@end
