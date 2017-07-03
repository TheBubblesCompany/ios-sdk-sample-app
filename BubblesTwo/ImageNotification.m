//
//  BBImageNotificationViewController.m
//  BubblesFrameworkDemo
//
//  Created by Pierre RACINE on 21/12/2015.
//  Copyright © 2015 Absolutlabs. All rights reserved.
//

#import "ImageNotification.h"
#import "WebViewNotification.h"

@interface ImageNotification ()

@property (strong, nonatomic) UIImageView *imageView;

@property (strong, nonatomic) UIButton *buttonShowMore;

- (void)showMore:(UIButton *)sender;
- (void)close:(UIButton *)sender;

@end

@implementation ImageNotification

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor colorWithRed:44.f/255.f
                                                 green:62.f/255.f
                                                  blue:80.f/255.f
                                                  alpha:1.f]];
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 70 , self.view.frame.size.width , self.view.frame.size.height - 80)];
    [_imageView setUserInteractionEnabled:YES];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    UITapGestureRecognizer *singleTap =  [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showMore:)];
    [singleTap setNumberOfTapsRequired:1];
    [_imageView addGestureRecognizer:singleTap];
    
    
    
    UIButton * btnClose = [[UIButton alloc] initWithFrame:CGRectMake(20, 25, 30, 30)];
    [btnClose setImage:[UIImage imageNamed:@"closeButton"] forState:UIControlStateNormal];
    [btnClose addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:btnClose];
    [self.view addSubview:_imageView];
    
  //  [_buttonShowMore.layer setCornerRadius:4];
    
    [self displayImage];
}

-(void)showMore:(UIGestureRecognizer *)recognizer {
    NSLog(@"image clicked");
    
    NSDictionary * dico = [_infos objectForKey:@"image"];
    
    if([[dico allKeys]containsObject:@"action"] && [[dico objectForKey:@"action"]isKindOfClass:[NSDictionary class]])
    {
        if([[[dico objectForKey:@"action"]objectForKey:@"type"]isEqualToString:@"WVW"])
        {
            
            NSLog(@"image push ok");
            
            WebViewNotification * bubblesWebView = [[WebViewNotification alloc]init];
          //  [bubblesWebView setStatusBarStyle:_statusBarStyle];
            [bubblesWebView.view setBackgroundColor:self.view.backgroundColor];
            
            NSString * url = [[dico objectForKey:@"action"]objectForKey:@"url"];
            
            [bubblesWebView setWebviewURL:url];
            [self.navigationController pushViewController:bubblesWebView animated:YES];
            
            
            
        }
        else if ([[[dico objectForKey:@"action"]objectForKey:@"type"]isEqualToString:@"URI"])
        {
            NSDictionary * dictionaryURI = [[dico objectForKey:@"action"]objectForKey:@"uri"];
            NSURL * urlURIDefault = nil;
            NSURL * urlURIFallback = nil;
            
            if([[dictionaryURI allKeys]containsObject:@"default"] && [[dictionaryURI objectForKey:@"default"]isKindOfClass:[NSString class]])
                urlURIDefault = [NSURL URLWithString:[dictionaryURI objectForKey:@"default"]];
            
            if([[dictionaryURI allKeys]containsObject:@"fallback"] && [[dictionaryURI objectForKey:@"fallback"]isKindOfClass:[NSString class]])
                urlURIFallback = [NSURL URLWithString:[dictionaryURI objectForKey:@"fallback"]];
            
            if(![[UIApplication sharedApplication]openURL:urlURIDefault])
                [[UIApplication sharedApplication]openURL:urlURIFallback];
            
        }
    }
    
    /*if (_infos) {
        
        NSDictionary * dico = [_infos objectForKey:@"image"];
        
        if([[dico allKeys]containsObject:@"action"] && [[dico objectForKey:@"action"]isKindOfClass:[NSDictionary class]])
        {
            if([[[dico objectForKey:@"action"]objectForKey:@"type"]isEqualToString:@"WVW"])
            {
                NSString * url = [[dico objectForKey:@"action"]objectForKey:@"url"];
                [[UIApplication sharedApplication]openURL:[NSURL URLWithString:url]];
            }
            else if ([[[dico objectForKey:@"action"]objectForKey:@"type"]isEqualToString:@"URI"])
            {
                NSDictionary * dictionaryURI = [[dico objectForKey:@"action"]objectForKey:@"uri"];
                NSURL * urlURIDefault = nil;
                NSURL * urlURIFallback = nil;
                
                if([[dictionaryURI allKeys]containsObject:@"default"] && [[dictionaryURI objectForKey:@"default"]isKindOfClass:[NSString class]])
                    urlURIDefault = [NSURL URLWithString:[dictionaryURI objectForKey:@"default"]];
                
                if([[dictionaryURI allKeys]containsObject:@"fallback"] && [[dictionaryURI objectForKey:@"fallback"]isKindOfClass:[NSString class]])
                    urlURIFallback = [NSURL URLWithString:[dictionaryURI objectForKey:@"fallback"]];
                
                if(![[UIApplication sharedApplication]openURL:urlURIDefault])
                    [[UIApplication sharedApplication]openURL:urlURIFallback];
                
            }
        }
        
    }*/
}



-(void) displayImage
{
    if(!_infos)
        return;
    
    if([[_infos allKeys]containsObject:@"image"] && [[[_infos objectForKey:@"image"]allKeys]containsObject:@"url"])
    {
        NSString * imageURL = [[_infos objectForKey:@"image"]objectForKey:@"url"];
        if(imageURL)
        {
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
            dispatch_async(queue, ^(void) {
                
                NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
                if (imageData) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [_imageView setImage:[UIImage imageWithData:imageData]];
                    });
                }
            });
        }
        
    }
}





#pragma mark - Actions





- (void)close:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
- (void)showMore:(UIButton *)sender {
    
    if (_infos) {
        
        NSDictionary * dico = [_infos objectForKey:@"image"];
        
        if([[dico allKeys]containsObject:@"action"] && [[dico objectForKey:@"action"]isKindOfClass:[NSDictionary class]])
        {
            if([[[dico objectForKey:@"action"]objectForKey:@"type"]isEqualToString:@"WVW"])
            {
                NSString * url = [[dico objectForKey:@"action"]objectForKey:@"url"];
                [[UIApplication sharedApplication]openURL:[NSURL URLWithString:url]];
            }
            else if ([[[dico objectForKey:@"action"]objectForKey:@"type"]isEqualToString:@"URI"])
            {
                NSDictionary * dictionaryURI = [[dico objectForKey:@"action"]objectForKey:@"uri"];
                NSURL * urlURIDefault = nil;
                NSURL * urlURIFallback = nil;
                
                if([[dictionaryURI allKeys]containsObject:@"default"] && [[dictionaryURI objectForKey:@"default"]isKindOfClass:[NSString class]])
                    urlURIDefault = [NSURL URLWithString:[dictionaryURI objectForKey:@"default"]];
                
                if([[dictionaryURI allKeys]containsObject:@"fallback"] && [[dictionaryURI objectForKey:@"fallback"]isKindOfClass:[NSString class]])
                    urlURIFallback = [NSURL URLWithString:[dictionaryURI objectForKey:@"fallback"]];
                
                if(![[UIApplication sharedApplication]openURL:urlURIDefault])
                    [[UIApplication sharedApplication]openURL:urlURIFallback];
                
            }
        }
        
    }
}*/





@end
