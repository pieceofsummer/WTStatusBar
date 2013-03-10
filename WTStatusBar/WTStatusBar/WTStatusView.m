//
//  WTStatusView.m
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

#import "WTStatusView.h"

#define kWTProgressBarHeight 2

@implementation WTStatusView

@synthesize progress = _progress;

- (id)init
{
    self = [super init];
    if (self)
    {
        [self initView];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initView];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self initView];
    }
    return self;
}

- (void)initView
{
    self.backgroundColor = [UIColor blackColor];
    
    statusText = [[UILabel alloc] init];
    statusText.backgroundColor = [UIColor clearColor];
    statusText.textColor = [UIColor colorWithWhite:0.75 alpha:1.0];
    statusText.font = [UIFont boldSystemFontOfSize:13];
    statusText.textAlignment = NSTextAlignmentCenter;
    statusText.lineBreakMode = NSLineBreakByTruncatingTail;    
    [self addSubview:statusText];
    
    progressBar = [[UIView alloc] init];
    progressBar.opaque = YES;
    
    [self addSubview:progressBar];
}

- (void)dealloc
{
    statusText = nil;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    statusText.frame = self.bounds;
    
    [self setProgress:_progress];
}

- (void)setStatusBarColor:(UIColor *)color
{
    CGFloat windowAlpha = ([[UIApplication sharedApplication] statusBarStyle] == UIStatusBarStyleBlackTranslucent) ? 0.5 : 1.0;
    self.backgroundColor = [color colorWithAlphaComponent:windowAlpha];
}

- (void)setStatusTextColor:(UIColor*)color
{
    statusText.textColor = color;
}

- (void)setProgressBarColor:(UIColor *)color
{
    progressBar.backgroundColor = color;
}

- (void)setStatusText:(NSString *)text
{
    statusText.text = text;
}

- (void)setProgress:(CGFloat)progress
{
    _progress = MAX(0.0, MIN(1.0, progress));
    progressBar.frame = CGRectMake(0, 0, _progress * CGRectGetWidth(self.bounds), kWTProgressBarHeight);
}

@end
