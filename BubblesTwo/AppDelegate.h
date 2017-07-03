//
//  AppDelegate.h
//  BubblesTwo
//
//  Created by Pierre RACINE on 30/03/2016.
//  Copyright © 2016 Absolutlabs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Bubbles/Bubbles.h>
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, BubblesDelegate, UNUserNotificationCenterDelegate>

@property (strong, nonatomic) UIWindow * _Nullable window;

@end

