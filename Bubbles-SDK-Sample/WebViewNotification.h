//
//  BBWebViewNotificationViewController.h
//  BubblesFrameworkDemo
//
//  Created by Karim Koriche on 21/12/2015.
//  Copyright © 2015 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewNotification : UIViewController

@property (nonatomic, strong) NSDictionary * infos;

@property (nonatomic) UIStatusBarStyle statusBarStyle;
@property (nonatomic, strong) NSString * webviewURL;
@property (nonatomic, strong) UIImage * imageButton;

@end
