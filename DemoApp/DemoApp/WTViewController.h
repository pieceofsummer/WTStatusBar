//
//  WTViewController.h
//  DemoApp
//
//  Created by Alex Skalozub on 3/8/13.
//  Copyright (c) 2013 Alex Skalozub. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WTViewController : UIViewController
{
    CGFloat _progress;
}

- (IBAction)clearStatus:(id)sender;

- (IBAction)setTextStatus:(id)sender;
- (IBAction)setTextStatus2sec:(id)sender;
- (IBAction)setTextStatusProgress:(id)sender;

@end
