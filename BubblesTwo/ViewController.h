//
//  ViewController.h
//  BubblesTwo
//
//  Created by Karim Koriche on 28/11/2016.
//  Copyright © 2016 Absolutlabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) NSString * currentServiceName;
@property (strong, nonatomic) NSString * currentServiceId;
@property (strong, nonatomic) NSNumber * currentFullscreenMode;

@property (weak, nonatomic) IBOutlet UILabel *currentUserLabel;
@property (weak, nonatomic) IBOutlet UITextField *userTextfield;
@property (weak, nonatomic) IBOutlet UIButton *UpdateButton;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIButton *btnGetServices;
@property (weak, nonatomic) IBOutlet UIButton *btnChooseService;
@property (weak, nonatomic) IBOutlet UIButton *btnLoadUrl;
@property (weak, nonatomic) IBOutlet UIButton *btnDisplayWebview;
@property (strong, nonatomic) NSMutableDictionary * myServices;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activity;
@property (strong, nonatomic) NSString * userID;


-(void)serviceSelected;

@end
