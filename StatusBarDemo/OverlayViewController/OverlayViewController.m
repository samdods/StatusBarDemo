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

- (IBAction)didTap:(UITapGestureRecognizer *)tapGesture
{
  BOOL shouldOpen = self.view.frame.origin.y > 0;
  [UIView animateWithDuration:0.6 animations:^{
    CGRect frame = self.view.bounds;
    frame.origin.y = shouldOpen ? 0 : CGRectGetHeight(self.view.bounds) - 80;
    self.view.frame = frame;
  }];
}

- (IBAction)didPan:(UIPanGestureRecognizer *)panGesture
{
  CGPoint translation = [panGesture translationInView:self.view];
  CGPoint velocity = [panGesture velocityInView:self.view];
  BOOL shouldOpen = velocity.y < 0;
  switch (panGesture.state) {
    case UIGestureRecognizerStateBegan:
      self.containerOffsetYWhenPanBegan = self.view.frame.origin.y;
      break;
    case UIGestureRecognizerStateChanged: {
      self.view.hidden = NO;
      CGRect frame = self.view.bounds;
      frame.origin.y = MAX(0, self.containerOffsetYWhenPanBegan + translation.y);
      self.view.frame = frame;
    } break;
    case UIGestureRecognizerStateEnded:
    case UIGestureRecognizerStateCancelled:
    case UIGestureRecognizerStateFailed: {
      CGFloat targetOffsetY = shouldOpen ? 0 : CGRectGetHeight(self.view.bounds) - 80;
      CGFloat distance = fabsf(CGRectGetMinY(self.view.frame) - targetOffsetY);
      CGFloat speed = fabsf(velocity.y);
      NSTimeInterval defaultDuration = distance / 813;
      NSTimeInterval duration = MAX(defaultDuration, (distance / speed));
      [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CGRect frame = self.view.bounds;
        frame.origin.y = targetOffsetY;
        self.view.frame = frame;
      } completion:NULL];
    } break;
    default:
      break;
  }
}

@end
