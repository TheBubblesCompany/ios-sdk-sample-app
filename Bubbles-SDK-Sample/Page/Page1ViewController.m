//
//  Page1ViewController.m
//  Bubbles-SDK-Sample
//
//  Created by Aurélien SEMENCE on 13/10/2017.
//  Copyright © 2017 The Bubbles Company. All rights reserved.
//

#import "Page1ViewController.h"
#import <Bubbles/Bubbles.h>

@implementation Page1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    Bubbles *bubbles = [Bubbles instance];
    [bubbles addMagicButton:@"ab15be9050ce23b6efb7d7c8e4c3858f" forController: self];
    [bubbles addMagicButton:@"0a5b3913cbc9a9092311630e869b4442" forController: self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
