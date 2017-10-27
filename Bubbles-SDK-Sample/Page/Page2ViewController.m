//
//  Page2ViewController.m
//  Bubbles-SDK-Sample
//
//  Created by Aurélien SEMENCE on 13/10/2017.
//  Copyright © 2017 The Bubbles Company. All rights reserved.
//

#import "Page2ViewController.h"
#import <Bubbles/Bubbles.h>

@implementation Page2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    Bubbles *bubbles = [Bubbles instance];
    [bubbles addMagicButton:@"8d02065b7848638f44a1313ad889213e" forController: self];
    [bubbles addMagicButton:@"b51ddc997546f116df73b8deb39fcbca" forController: self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
