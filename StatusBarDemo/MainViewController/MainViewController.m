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
@end

@implementation MainViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  UIWindow *statusBarWindow = [[UIApplication sharedApplication] valueForKey:@"statusBarWindow"];
  CGRect frame = self.view.bounds;
  frame.origin.y = CGRectGetHeight(self.view.bounds) - 80;
  self.overlayViewController.view.frame = frame;
  [statusBarWindow addSubview:self.overlayViewController.view];
}

- (OverlayViewController *)overlayViewController
{
  return _overlayViewController ?: ({
    _overlayViewController = [OverlayViewController new];
  });
}

@end
