//
//  WTStatusViewController.h
//  WTStatusBar
//
//  Created by Alex Skalozub on 3/8/13.
//  Copyright (c) 2013 Alex Skalozub. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WTStatusView : UIView
{
    UILabel *statusText;
    UIView *progressBar;
}

- (void) setStatusText:(NSString*)text;
- (void) setStatusBarColor:(UIColor*)color;
- (void) setStatusTextColor:(UIColor*)color;
- (void) setProgressBarColor:(UIColor*)color;
- (void) setProgress:(CGFloat)progress;

@property (nonatomic, assign, setter = setProgress:) CGFloat progress;

@end
