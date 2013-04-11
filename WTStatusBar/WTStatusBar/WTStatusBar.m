//
//  WTStatusBar.m
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

#import "WTStatusBar.h"
#import "WTStatusWindow.h"
#import "WTStatusView.h"
#import <objc/runtime.h>

#define kWTStatusBarWindow @"StatusBarWindow"
#define kWTFadeDuration 0.2
#define kWTProgressDuration 0.1

static UIColor* _textColor = nil;
static UIColor* _backgroundColor = nil;
static UIColor* _progressBarColorFrom = nil;
static UIColor* _progressBarColorTo = nil;
static UIFont* _textFont = nil;

@implementation WTStatusBar

+ (void)initialize
{
    _textColor = [UIColor colorWithWhite:0.75 alpha:1.0];
    _backgroundColor = [UIColor blackColor];
    _progressBarColorFrom = [UIColor greenColor];
    _progressBarColorTo = [UIColor greenColor];
    _textFont = [UIFont boldSystemFontOfSize:13];
}

+ (UIColor*)textColor
{
    return _textColor;
}

+ (void)setTextColor:(UIColor *)textColor
{
    NSParameterAssert(textColor != nil);
    _textColor = textColor;
    
    UIWindow *mainWindow = [[UIApplication sharedApplication] keyWindow];
    if (mainWindow != nil)
    {
        WTStatusWindow *statusWindow = (WTStatusWindow*)objc_getAssociatedObject(mainWindow, kWTStatusBarWindow);
        if (statusWindow != nil)
            [statusWindow.statusView setStatusTextColor:_textColor];
    }
}

+ (UIColor*)backgroundColor
{
    return _backgroundColor;
}

+ (void)setBackgroundColor:(UIColor *)backgroundColor
{
    NSParameterAssert(backgroundColor != nil);
    _backgroundColor = backgroundColor;
    
    UIWindow *mainWindow = [[UIApplication sharedApplication] keyWindow];
    if (mainWindow != nil)
    {
        WTStatusWindow *statusWindow = (WTStatusWindow*)objc_getAssociatedObject(mainWindow, kWTStatusBarWindow);
        if (statusWindow != nil)
            [statusWindow.statusView setStatusBarColor:_backgroundColor];
    }
}

+ (UIColor*)progressBarColor
{
    return _progressBarColorFrom;
}

+ (void)setProgressBarColor:(UIColor *)progressBarColor
{
    [self setProgressBarGradientColorFrom:progressBarColor to:progressBarColor];
}

+ (void)setProgressBarGradientColorFrom:(UIColor *)fromColor to:(UIColor *)toColor
{
    NSParameterAssert(fromColor != nil && toColor != nil);
    _progressBarColorFrom = fromColor;
    _progressBarColorTo = toColor;

    UIWindow *mainWindow = [[UIApplication sharedApplication] keyWindow];
    if (mainWindow != nil)
    {
        WTStatusWindow *statusWindow = (WTStatusWindow*)objc_getAssociatedObject(mainWindow, kWTStatusBarWindow);
        if (statusWindow != nil)
            [statusWindow.statusView setProgressBarColorFrom:_progressBarColorFrom to:_progressBarColorTo];
    }
}

+ (UIFont *)textFont
{
    return _textFont;
}

+ (void)setTextFont:(UIFont *)textFont
{
    NSParameterAssert(textFont != nil);
    _textFont = textFont;
    
    UIWindow *mainWindow = [[UIApplication sharedApplication] keyWindow];
    if (mainWindow != nil)
    {
        WTStatusWindow *statusWindow = (WTStatusWindow*)objc_getAssociatedObject(mainWindow, kWTStatusBarWindow);
        if (statusWindow != nil)
            [statusWindow.statusView setStatusTextFont:_textFont];
    }
}

+ (void)clearStatus
{
    [WTStatusBar clearStatusAnimated:NO];
}

+ (void)clearStatusAnimated:(BOOL)animated
{
    UIWindow *mainWindow = [[UIApplication sharedApplication] keyWindow];
    if (mainWindow == nil) return;
    
    WTStatusWindow *statusWindow = (WTStatusWindow*)objc_getAssociatedObject(mainWindow, kWTStatusBarWindow);
    if (statusWindow != nil)
    {
        if (animated)
        {
            [UIView animateWithDuration:kWTFadeDuration animations:^{
                statusWindow.alpha = 0.0;
            } completion:^(BOOL finished) {
                statusWindow.hidden = YES;
            }];
        }
        else
        {
            statusWindow.hidden = YES;
        }
    }
}

+ (void)setStatusText:(NSString *)text
{
    [WTStatusBar setStatusText:text timeout:0 animated:NO];
}

+ (void)setStatusText:(NSString *)text animated:(BOOL)animated
{
    [WTStatusBar setStatusText:text timeout:0 animated:animated];
}

+ (void)setStatusText:(NSString *)text timeout:(NSTimeInterval)timeout animated:(BOOL)animated
{
    UIWindow *mainWindow = [[UIApplication sharedApplication] keyWindow];
    if (mainWindow == nil) return;
    
    // create status window if it not exists
    
    WTStatusWindow *statusWindow = (WTStatusWindow*)objc_getAssociatedObject(mainWindow, kWTStatusBarWindow);
    if (statusWindow == nil)
    {
        statusWindow = [[WTStatusWindow alloc] init];
        statusWindow.alpha = 0.0;
        statusWindow.hidden = YES;
        
        objc_setAssociatedObject(mainWindow, kWTStatusBarWindow, statusWindow, OBJC_ASSOCIATION_RETAIN);
    }

    // setup window parameters
    
    [statusWindow.statusView setStatusBarColor:_backgroundColor];
    [statusWindow.statusView setStatusTextColor:_textColor];
    [statusWindow.statusView setProgressBarColorFrom:_progressBarColorFrom to:_progressBarColorTo];
    [statusWindow.statusView setStatusTextFont:_textFont];
    [statusWindow.statusView setStatusText:text];
    [statusWindow.statusView setProgress:0.0];
    
    if (animated)
    {
        [UIView animateWithDuration:kWTFadeDuration animations:^{
            statusWindow.hidden = NO;
            statusWindow.alpha = 1.0;
        }];
    }
    else
    {
        statusWindow.alpha = 1.0;
        statusWindow.hidden = NO;
    }
    
    NSInteger iteration = ++statusWindow.iteration;
    
    if (timeout > 0)
    {
        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MAX(kWTFadeDuration, timeout) * NSEC_PER_SEC));
        dispatch_after(time, dispatch_get_main_queue(), ^(void){
            if (statusWindow.iteration == iteration)
            {
                // clear only status set by this call
                [WTStatusBar clearStatusAnimated:animated];
            }
        });
    }
}

+ (void)setProgress:(CGFloat)progress
{
    [WTStatusBar setProgress:progress animated:NO];
}

+ (void)setProgress:(CGFloat)progress animated:(BOOL)animated
{
    UIWindow *mainWindow = [[UIApplication sharedApplication] keyWindow];
    if (mainWindow == nil) return;
    
    WTStatusWindow *statusWindow = (WTStatusWindow*)objc_getAssociatedObject(mainWindow, kWTStatusBarWindow);
    if (statusWindow != nil)
    {
        if (animated)
        {
            [UIView animateWithDuration:kWTProgressDuration animations:^{
                [statusWindow.statusView setProgress:progress];
            }];
        }
        else
        {
            [statusWindow.statusView setProgress:progress];
        }
    }
}

@end
