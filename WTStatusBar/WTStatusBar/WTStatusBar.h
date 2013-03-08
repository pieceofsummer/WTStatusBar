//
//  WTStatusBar.h
//  WTStatusBar
//
//  Created by Alex Skalozub on 3/8/13.
//  Copyright (c) 2013 Alex Skalozub. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WTStatusBar : NSObject

// ---------------------------------------------------
// status bar appearance
// ---------------------------------------------------

+ (UIColor*) backgroundColor;
+ (void) setBackgroundColor:(UIColor*)backgroundColor;

+ (UIColor*) textColor;
+ (void) setTextColor:(UIColor*)textColor;

+ (UIColor*) progressBarColor;
+ (void) setProgressBarColor:(UIColor*)progressBarColor;

// ---------------------------------------------------
// status manipulation
// ---------------------------------------------------

+ (void) clearStatus;
+ (void) clearStatusAnimated:(BOOL)animated;

// each of the folowing methods resets progress
+ (void) setStatusText:(NSString*)text;
+ (void) setStatusText:(NSString *)text animated:(BOOL)animated;
+ (void) setStatusText:(NSString *)text timeout:(NSTimeInterval)timeout animated:(BOOL)animated;

// setProgress doesn't show status, just adjusts progress bar position
// you need to manually show status bar by calling any of above methods
+ (void) setProgress:(CGFloat)progress;
+ (void) setProgress:(CGFloat)progress animated:(BOOL)animated;

@end
