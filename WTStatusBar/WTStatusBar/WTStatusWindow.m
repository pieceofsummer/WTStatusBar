//
//  WTStatusWindow.m
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

#import "WTStatusWindow.h"
#import "WTStatusView.h"

@implementation WTStatusWindow

@synthesize iteration = _iteration;

- (id)init
{
    self = [super init];
    if (self) {
        [self initWindow];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initWindow];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self initWindow];
    }
    return self;
}

- (void)initWindow
{
    CGRect screenRect = [UIScreen mainScreen].bounds;
    
    self.frame = screenRect;
    self.backgroundColor = [UIColor clearColor];
    self.windowLevel = UIWindowLevelStatusBar;
    self.userInteractionEnabled = NO;
    self.autoresizesSubviews = YES;
    
    CGRect statusBarRect = [[UIApplication sharedApplication] statusBarFrame];
    _statusView = [[WTStatusView alloc] initWithFrame:statusBarRect];
    
    [self addSubview:_statusView];
    
    [self didRotate:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didRotate:) name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
    
    _statusView = nil;
}

- (WTStatusView*)statusView
{
    return _statusView;
}

- (void)didRotate:(NSNotification*)notification
{
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    [self setTransform:[self transformForOrientation:orientation]];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGRect statusBarRect = [[UIApplication sharedApplication] statusBarFrame];
    if (UIInterfaceOrientationIsPortrait(orientation))
    {
        self.bounds = CGRectMake(0, 0, CGRectGetWidth(screenRect), CGRectGetHeight(screenRect));
        self.statusView.frame = CGRectMake(0, 0, CGRectGetWidth(statusBarRect), CGRectGetHeight(statusBarRect));
    }
    else
    {
        self.bounds = CGRectMake(0, 0, CGRectGetHeight(screenRect), CGRectGetWidth(screenRect));
        self.statusView.frame = CGRectMake(0, 0, CGRectGetHeight(statusBarRect), CGRectGetWidth(statusBarRect));
    }
    
    [self.statusView setNeedsLayout];
}

#define DegreesToRadians(degrees) (degrees * M_PI / 180)

- (CGAffineTransform)transformForOrientation:(UIInterfaceOrientation)orientation {
    switch (orientation) {
            
        case UIInterfaceOrientationLandscapeLeft:
            return CGAffineTransformMakeRotation(-DegreesToRadians(90));
            
        case UIInterfaceOrientationLandscapeRight:
            return CGAffineTransformMakeRotation(DegreesToRadians(90));
            
        case UIInterfaceOrientationPortraitUpsideDown:
            return CGAffineTransformMakeRotation(DegreesToRadians(180));
            
        case UIInterfaceOrientationPortrait:
        default:
            return CGAffineTransformMakeRotation(DegreesToRadians(0));
    }
}

@end
