//
//  AppDelegate.m
//  Bubbles SDK Sample
//
//  Created by Karim Koriche on 27/06/2017.
//  Copyright © 2017 Bubbles Company.  All rights reserved.
//

#import "AppDelegate.h"
#import <Bubbles/Bubbles.h>
#import "ViewController.h"



@interface AppDelegate ()
@end


@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSString * user = @"";
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"currentUser"])
    {
        user = [[NSUserDefaults standardUserDefaults] objectForKey:@"currentUser"];
    }
    
    [Bubbles initWithAPIKey:@"a9e389c456315841705cc4241119ed58" andUserId:user andForceLocalizationPermission:NO andForceNotificationPermission:NO andApplication:application];
    [Bubbles setDebugLogEnabled:YES];
    
    UINavigationController *navigationController = (UINavigationController*) self.window.rootViewController;
    [[[navigationController viewControllers] objectAtIndex:0] performSegueWithIdentifier:@"mainViewSegue" sender:self];

    return YES;
}


#pragma mark - Notifications

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    [Bubbles didReceiveLocalNotification:notification.userInfo withApplicationState:application.applicationState];
}


- (void)userNotificationCenter:(UNUserNotificationCenter *)center
       willPresentNotification:(UNNotification *)notification
         withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler
{
    if([[notification.request.content.userInfo objectForKey:@"category"] isEqualToString:@"BubbleBeacon"])
        [Bubbles didReceiveLocalNotification:notification.request.content.userInfo withApplicationState:UIApplicationStateActive];
}


- (void)userNotificationCenter:(UNUserNotificationCenter *)center
didReceiveNotificationResponse:(UNNotificationResponse *)response
         withCompletionHandler:(void (^)())completionHandler
{
    if ([[response.notification.request.content.userInfo objectForKey:@"category"]
         isEqualToString:@"BubbleBeacon"])
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if([[[[[UIApplication sharedApplication]delegate]window]rootViewController] presentedViewController])
            {
                [[[[[UIApplication sharedApplication]delegate]window]rootViewController] dismissViewControllerAnimated:NO completion:^{
                }];
            }
        });
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [Bubbles didReceiveLocalNotification:response.notification.request.content.userInfo withApplicationState:UIApplicationStateBackground];
        });
    }
}


- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [Bubbles didEnterBackground];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [Bubbles didBecomeActive];
}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err {
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}


@end
