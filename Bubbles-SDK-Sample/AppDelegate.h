//
//  AppDelegate.h
//  Bubbles SDK Sample
//
//  Created by Karim Koriche on 27/06/2017.
//  Copyright © 2017 Bubbles Company.  All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Bubbles/Bubbles.h>
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, BubblesDelegate, UNUserNotificationCenterDelegate>

@property (strong, nonatomic) UIWindow * _Nullable window;

@end

