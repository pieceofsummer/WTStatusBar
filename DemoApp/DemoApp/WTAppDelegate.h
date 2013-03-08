//
//  WTAppDelegate.h
//  DemoApp
//
//  Created by Alex Skalozub on 3/8/13.
//  Copyright (c) 2013 Alex Skalozub. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WTViewController;

@interface WTAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) WTViewController *viewController;

@end
