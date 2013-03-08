//
//  WTStatusWindow.h
//  WTStatusBar
//
//  Created by Alex Skalozub on 3/8/13.
//  Copyright (c) 2013 Alex Skalozub. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WTStatusView;

@interface WTStatusWindow : UIWindow
{
    WTStatusView* _statusView;
}

- (WTStatusView*)statusView;

@property (nonatomic, assign) NSInteger iteration;

@end
