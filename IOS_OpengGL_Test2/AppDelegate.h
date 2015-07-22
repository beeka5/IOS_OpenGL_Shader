//
//  AppDelegate.h
//  IOS_OpengGL_Test2
//
//  Created by macist on 7/22/15.
//  Copyright (c) 2015 flip. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GLViewController;


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, retain)  GLViewController *rootController;

@end
