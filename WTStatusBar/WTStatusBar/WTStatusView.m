//
//  WTStatusViewController.m
//  WTStatusBar
//
//  Created by Alex Skalozub on 3/8/13.
//  Copyright (c) 2013 Alex Skalozub. All rights reserved.
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
