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
  self.topWindow.windowLevel = UIWindowLevelStatusBar;
  [self.topWindow makeKeyAndVisible];
}

- (OverlayViewController *)overlayViewController
{
  return _overlayViewController ?: ({
    _overlayViewController = [OverlayViewController new];
  });
}

@end
