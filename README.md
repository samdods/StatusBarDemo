StatusBarDemo
=============

# The Effect

<img src="//i.imgflip.com/6skj5.gif" title="made at imgflip.com"/>

# The Secret

It's actually very easy. `UIApplication` has a `statusBarWindow` property, which is of type `UIStatusBarWindow`. This is in the private API. However, it is just a subclass of `UIWindow`, which is a subclass of `UIView`, so we can add views to it, just as if it were the application's key window.

Access the status bar window, like so:

```objc
UIWindow *statusBarWindow = [[UIApplication sharedApplication] valueForKey:@"statusBarWindow"];
```

Then add your modal view to this window and it will appear in front of the status bar. The window frame is equal to the size of the screen and the background is transparent, so you can then treat your modal view as any other view that would take up the whole screen.

The following code adds the modal view to the window and positions it at the bottom, with 80 points visible.

```
CGRect frame = self.view.bounds;
frame.origin.y = CGRectGetHeight(self.view.bounds) - 80;
self.overlayViewController.view.frame = frame;
[statusBarWindow addSubview:self.overlayViewController.view];
```
