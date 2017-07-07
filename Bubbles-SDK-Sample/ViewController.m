//
//  ViewController.m
//  Bubbles SDK Sample
//
//  Created by Karim Koriche on 28/11/2016.
//  Copyright © 2017 Bubbles Company.  All rights reserved.
//

#import "ViewController.h"
#import <Bubbles/Bubbles.h>
#import <Bubbles/BubbleServiceView.h>
#import "ServicesTableViewController.h"
#import "ServiceViewController.h"
#import "ImageNotification.h"
#import "WebViewNotification.h"

@interface ViewController () <BubblesDelegate, UINavigationControllerDelegate>
{
    ServicesTableViewController * tableServices;
}
@end

#define kAnimationDuration 0.3


@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _UpdateButton.layer.cornerRadius = 5;
    _btnGetServices.layer.cornerRadius = 5;
    _btnChooseService.layer.cornerRadius = 5;
    
    [_btnGetServices setUserInteractionEnabled:YES];
    [_btnGetServices setBackgroundColor:[UIColor colorWithRed:30/255.0 green:122/255.0 blue:65/255.0 alpha:1.0]];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
     _activity.alpha = 0;
    [_activity startAnimating];
    _activity.alpha = 1.0;
    
    NSString * lastUser = [[NSUserDefaults standardUserDefaults] objectForKey:@"currentUser"];
    
    if (lastUser)
        _userID = lastUser;
    
    [Bubbles setDelegate:self];
}



#pragma mark - Main methods


- (IBAction)getServices:(id)sender {
    [Bubbles getServices];
    
    _activity.alpha = 1.0;
    [_activity startAnimating];
}


- (IBAction)chooseService:(id)sender {
    
    tableServices = [[ServicesTableViewController alloc] initWithStyle:UITableViewStylePlain];
    tableServices.VC = self;
    tableServices.services = _myServices;
    tableServices.view.backgroundColor = self.view.backgroundColor;
    
    [self presentViewController:tableServices animated:YES completion:^{
        
    }];
}

- (IBAction)UpdateUser:(id)sender {
    
    _userID = _userTextfield.text;
    
    if (_userID)
    {
        [[NSUserDefaults standardUserDefaults]setObject:_userID forKey:@"currentUser"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    
    [_label setText:@""];
    
    [Bubbles updateUserId:_userTextfield.text];
    
    [self.view endEditing:YES];
    
    _activity.alpha = 1.0;
    [_activity startAnimating];
    
}


-(void)performLoadService
{
    [Bubbles loadServiceWithId:_currentServiceId];
    
    BubbleServiceView * webviewService = [Bubbles getWebviewService];
    
    if([[[[[UIApplication sharedApplication]delegate]window]rootViewController]presentedViewController])
    {
        [[[[[UIApplication sharedApplication]delegate]window]rootViewController] dismissViewControllerAnimated:NO completion:nil];
    }
    
    if ([_currentFullscreenMode intValue] == 0)
    {
        [webviewService.webviewService setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        [webviewService.navigationItem setTitle:_currentServiceName];
        webviewService.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        [self setCustomBackButton:webviewService];
        
    }
    else
    {
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
        [self.navigationController.navigationBar setHidden:YES];
    }
    
    [self.navigationController pushViewController:webviewService animated:YES];
}


-(void)serviceSelected
{
    [_btnLoadUrl setUserInteractionEnabled:YES];
    [_btnLoadUrl setBackgroundColor:[UIColor colorWithRed:30/255.0 green:122/255.0 blue:65/255.0 alpha:1.0]];
    
    [Bubbles loadServiceWithId:_currentServiceId];
    
    BubbleServiceView * webviewService = [Bubbles getWebviewService];
    
    if([[[[[UIApplication sharedApplication]delegate]window]rootViewController]presentedViewController])
    {
        [[[[[UIApplication sharedApplication]delegate]window]rootViewController] dismissViewControllerAnimated:NO completion:nil];
    }
    
    if ([_currentFullscreenMode intValue] == 0)
    {
        [webviewService.webviewService setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        [webviewService.navigationItem setTitle:_currentServiceName];
        webviewService.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        [self setCustomBackButton:webviewService];
        
    }
    else
    {
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
        [self.navigationController.navigationBar setHidden:YES];
    }
    
    [self.navigationController pushViewController:webviewService animated:YES];
    
}







#pragma mark - Bubbles callbacks 


- (void) bubblesDidReceiveNotification:(NSDictionary *)infos
{
    if(infos && [[infos objectForKey:@"type"]isEqualToString:@"WVW"])
    {
        if ([[infos objectForKey:@"foreground"] isEqualToString:@"0"])
            [self presentWebviewWithInfos:infos];
    }
    else if (infos && [[infos objectForKey:@"type"]isEqualToString:@"IMG"])
    {
        if ([[infos objectForKey:@"foreground"] isEqualToString:@"0"])
            [self presentImageWithInfos:infos];
    }
    else if (infos && [[infos objectForKey:@"type"]isEqualToString:@"URI"])
    {
        if ([[infos objectForKey:@"foreground"] isEqualToString:@"0"])
            [self presentURIWithInfos:infos];
    }
    else if (infos && [[infos objectForKey:@"type"]isEqualToString:@"SRV"])
    {
        if ([[infos objectForKey:@"foreground"] isEqualToString:@"0"])
        {
            if ([self.navigationController.visibleViewController isKindOfClass:[BubbleServiceView class]])
            {
                [self.navigationController popViewControllerAnimated:NO];
            }
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                
                [self presentServiceWithInfos:infos];
                
            });
        }
    }
    
}


- (void) onClickNotification:(NSDictionary*)infos
{
    if ([self.navigationController.visibleViewController isKindOfClass:[BubbleServiceView class]])
    {
        [self.navigationController popViewControllerAnimated:NO];
    }
    
    if (infos && [[infos objectForKey:@"type"]isEqualToString:@"SRV"])
        [self presentServiceWithInfos:infos];
    else if (infos && [[infos objectForKey:@"type"]isEqualToString:@"IMG"])
        [self presentImageWithInfos:infos];
    else if (infos && [[infos objectForKey:@"type"]isEqualToString:@"WVW"])
        [self presentWebviewWithInfos:infos];
    else if (infos && [[infos objectForKey:@"type"]isEqualToString:@"URI"])
        [self presentURIWithInfos:infos];
}




-(void) onOpenService:(NSString *)serviceId
{
    NSMutableDictionary * services = [[NSUserDefaults standardUserDefaults] objectForKey:@"services"];
    
    if(services)
    {
        NSMutableDictionary * service = [services objectForKey:@"service"];
        
        BOOL flag = NO;
        for (NSMutableDictionary * srv in service) {
            
            if ([[srv objectForKey:@"id"] isEqualToString:serviceId])
            {
                [self popAction];
                
                flag = YES;
                
                _currentServiceName = [srv objectForKey:@"name"];
                _currentServiceId = [srv objectForKey:@"id"];
                _currentFullscreenMode = [NSNumber numberWithInt:[[srv objectForKey:@"fullscreen"] intValue]];
                
                [self performSelector:@selector(performLoadService) withObject:nil afterDelay:1];
                
                break;
            }
        }
    }
}

-(void) onCloseService
{
    [self popAction];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    [self.navigationController.navigationBar setHidden:YES];
}


- (void) onHybridServiceReady
{
    NSLog(@"Service ready.");
}


- (void) onHybridServiceTimeout
{
    [self popAction];
}


- (void) onServicesListLoaded: (NSDictionary*) services
{
    
    if (_userID.length > 0)
    {
        [_currentUserLabel setText:[NSString stringWithFormat:@"Current tag is %@", _userID]];
        [_label setText:@"Services loaded, please choose a service to launch."];
    }
    else
    {
        [_currentUserLabel setText:[NSString stringWithFormat:@"Please enter a tag"]];
        [_label setText:@""];
    }
    
    NSMutableAttributedString *text =
    [[NSMutableAttributedString alloc]
     initWithAttributedString: _currentUserLabel.attributedText];
    
    if (text.length > 0)
        [text addAttribute:NSForegroundColorAttributeName
                     value:[UIColor colorWithRed:236/255.0 green:100/255.0 blue:75/255.0 alpha:1.0]
                     range:NSMakeRange(15, _userID.length)];
    [_currentUserLabel setAttributedText: text];
    
    
    _activity.alpha = 0;
    [_activity stopAnimating];
    
    _myServices = [NSMutableDictionary new];
    _myServices = [NSMutableDictionary dictionaryWithDictionary:services];
    
    [_btnChooseService setUserInteractionEnabled:YES];
    [_btnChooseService setBackgroundColor:[UIColor colorWithRed:30/255.0 green:122/255.0 blue:65/255.0 alpha:1.0]];
    
    _userTextfield.text = @"";
}










#pragma mark - Methods to present the view.



-(void)presentServiceWithInfos:(NSDictionary*)infos
{
    _currentServiceName = [infos objectForKey:@"name"];
    _currentServiceId = [infos objectForKey:@"service_id"];
    _currentFullscreenMode = [NSNumber numberWithInt:[[infos objectForKey:@"fullscreen"] intValue]];
    
    
    [Bubbles loadServiceWithId:_currentServiceId];
    
    BubbleServiceView * webviewService = [Bubbles getWebviewService];
    
    if([[[[[UIApplication sharedApplication]delegate]window]rootViewController]presentedViewController])
    {
        [[[[[UIApplication sharedApplication]delegate]window]rootViewController] dismissViewControllerAnimated:YES completion:nil];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
    
    if ([_currentFullscreenMode intValue] == 0)
    {
        [webviewService.webviewService setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        [webviewService.navigationItem setTitle:_currentServiceName];
        webviewService.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        [self setCustomBackButton:webviewService];
        
    }
    else
    {
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
        [self.navigationController.navigationBar setHidden:YES];
    }
    
    [self.navigationController pushViewController:webviewService animated:YES];
        
        });
    
}


-(void)presentImageWithInfos:(NSDictionary*)infos
{
    ImageNotification * imageVC = [ImageNotification new];
    imageVC.infos = infos;
    
    UINavigationController *navCtrlr = [[UINavigationController alloc]initWithRootViewController:imageVC];
    navCtrlr.delegate = self;
    navCtrlr.navigationBarHidden = YES;
    
    if([[[[[UIApplication sharedApplication]delegate]window]rootViewController]presentedViewController])
    {
        [[[[[UIApplication sharedApplication]delegate]window]rootViewController] dismissViewControllerAnimated:NO completion:nil];
    }
    
    [self presentViewController:navCtrlr animated:YES completion:nil];
}

-(void)presentWebviewWithInfos:(NSDictionary*)infos
{
    WebViewNotification * webViewBeacon = [[WebViewNotification alloc]init];
    webViewBeacon.infos = infos;
    NSString * webViewURL = [infos objectForKey:@"url"];
    
    if(webViewURL)
    {
        if([[[[[UIApplication sharedApplication]delegate]window]rootViewController]presentedViewController])
        {
            [[[[[UIApplication sharedApplication]delegate]window]rootViewController] dismissViewControllerAnimated:NO completion:nil];
        }
        
        [self presentViewController:webViewBeacon animated:YES completion:nil];
    }
}

-(void)presentURIWithInfos:(NSDictionary*)infos
{
    NSDictionary * uri = [infos objectForKey:@"uri"];
    
    NSDictionary * dictionaryURI = uri;
    NSURL * urlURIDefault = nil;
    NSURL * urlURIFallback = nil;
    
    if([[dictionaryURI allKeys]containsObject:@"default"] && [[dictionaryURI objectForKey:@"default"]isKindOfClass:[NSString class]])
        urlURIDefault = [NSURL URLWithString:[dictionaryURI objectForKey:@"default"]];
    
    if([[dictionaryURI allKeys]containsObject:@"fallback"] && [[dictionaryURI objectForKey:@"fallback"]isKindOfClass:[NSString class]])
        urlURIFallback = [NSURL URLWithString:[dictionaryURI objectForKey:@"fallback"]];
    
    if([[[[[UIApplication sharedApplication]delegate]window]rootViewController]presentedViewController])
    {
        [[[[[UIApplication sharedApplication]delegate]window]rootViewController] dismissViewControllerAnimated:YES completion:^{
            if(![[UIApplication sharedApplication]openURL:urlURIDefault])
                [[UIApplication sharedApplication]openURL:urlURIFallback];
        }];
    }
    else
    {
        if(![[UIApplication sharedApplication]openURL:urlURIDefault])
            [[UIApplication sharedApplication]openURL:urlURIFallback];
    }
}








#pragma mark - Other methods


-(void)dismissKeyboard
{
    [_userTextfield resignFirstResponder];
}

-(void)popAction
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void) setCustomBackButton:(UIViewController*)viewContoller
{
    UIImage *buttonImage = [UIImage imageNamed:@"back-arrow-white.png"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:buttonImage forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 30, 30);
    [button addTarget:self action:@selector(popAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    viewContoller.navigationItem.leftBarButtonItem = customBarItem;
}


-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}


-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationItem setTitle:@"Bubbles SDK Sample"];
    [self.navigationItem setHidesBackButton:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [self.navigationController.navigationBar setHidden:NO];
}


- (UIColor *)colorFromHexString:(NSString *)hexString {
    
    if(!hexString)
        return nil;
    
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
