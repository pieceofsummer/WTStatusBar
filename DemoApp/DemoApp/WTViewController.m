//
//  WTViewController.m
//  DemoApp
//
//  Created by Alex Skalozub on 3/8/13.
//  Copyright (c) 2013 Alex Skalozub. All rights reserved.
//

#import "WTViewController.h"
#import <WTStatusBar/WTStatusBar.h>

@interface WTViewController ()

@end

@implementation WTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clearStatus:(id)sender
{
    [WTStatusBar clearStatusAnimated:YES];
}

- (void)setTextStatus:(id)sender
{
    [WTStatusBar setStatusText:@"Hello World!" animated:YES];
}

- (void)setTextStatus2sec:(id)sender
{
    [WTStatusBar setStatusText:@"Hello World!" timeout:2.0 animated:YES];
}

- (void)setTextStatusProgress:(id)sender
{
    [WTStatusBar setStatusText:@"Resolving host..." animated:YES];
    [self performSelector:@selector(setTextStatusProgress2) withObject:nil afterDelay:0.5];
}

- (void)setTextStatusProgress2
{
    [WTStatusBar setStatusText:@"Downloading data..." animated:YES];
    _progress = 0;
    [WTStatusBar setProgressBarColor:[UIColor greenColor]];
    [self performSelector:@selector(setTextStatusProgress3) withObject:nil afterDelay:0.1];
}

- (void)setTextStatusProgress3
{
    if (_progress < 1.0)
    {
        _progress += 0.1;
        [WTStatusBar setProgress:_progress animated:YES];
        [self performSelector:@selector(setTextStatusProgress3) withObject:nil afterDelay:0.1];
    }
    else
    {
        [WTStatusBar setStatusText:@"Parsing data..." animated:YES];
        _progress = 0;
        [WTStatusBar setProgressBarColor:[UIColor yellowColor]];
        [self performSelector:@selector(setTextStatusProgress4) withObject:nil afterDelay:0.3];
    }
}

- (void)setTextStatusProgress4
{
    if (_progress < 1.0)
    {
        _progress += 0.3;
        [WTStatusBar setProgress:_progress animated:YES];
        [self performSelector:@selector(setTextStatusProgress4) withObject:nil afterDelay:0.3];
    }
    else
    {
        [WTStatusBar setStatusText:@"Done!" timeout:0.5 animated:YES];
    }
}


@end
