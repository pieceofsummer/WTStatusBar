//
//  WTStatusBar.h
//  WTStatusBar
//
//  Created by Alex Skalozub on 3/8/13.
//  Copyright (c) 2013 Alex Skalozub.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), 
//  to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, 
//  and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//  
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//  
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
//  IN THE SOFTWARE.
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
