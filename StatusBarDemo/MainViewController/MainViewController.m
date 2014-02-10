//
//  MainViewController.m
//  StatusBarDemo
//
//  Created by Sam Dods on 10/02/2014.
//  Copyright (c) 2014 Sam Dods. All rights reserved.
//

#import "MainViewController.h"
#import "OverlayViewController.h"

@interface MainViewController ()
@property (strong, nonatomic) OverlayViewController *overlayViewController;
@property (strong, nonatomic) UIWindow *topWindow;
@end

@implementation MainViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.topWindow = [[UIWindow alloc] initWithFrame:self.view.bounds];
  [self.topWindow setRootViewController:self.overlayViewController];
  CGRect frame = self.view.bounds;
  frame.origin.y = CGRectGetHeight(self.view.bounds) - 80;
  self.topWindow.frame = frame;
  self.topWindow.windowLevel = UIWindowLevelStatusBar;
  [self.topWindow setHidden:NO];
}

- (OverlayViewController *)overlayViewController
{
  return _overlayViewController ?: ({
    _overlayViewController = [OverlayViewController new];
  });
}

- (IBAction)didTapShowOptions:(id)sender
{
  [self.overlayViewController show];
}

@end
