//
//  Page3ViewController.m
//  Bubbles-SDK-Sample
//
//  Created by Aurélien SEMENCE on 13/10/2017.
//  Copyright © 2017 The Bubbles Company. All rights reserved.
//

#import "Page3ViewController.h"
#import <Bubbles/Bubbles.h>

@implementation Page3ViewController {
    BOOL magicButtonShow;
}

- (instancetype)init {
    if (self = [super init]) {
        magicButtonShow = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    Bubbles *bubbles = [Bubbles instance];
    [bubbles addMagicButton:@"8d02065b7848638f44a1313ad889213e" forController: self];
    [bubbles registerMagicButton:@"b51ddc997546f116df73b8deb39fcbca" forController: self];
}

- (IBAction)toggleMagicButton:(id)sender {
    Bubbles *bubbles = [Bubbles instance];
    if (magicButtonShow) {
        NSError *hideMagicButtonError;
        [bubbles hideMagicButton:@"b51ddc997546f116df73b8deb39fcbca"
                   forController:self
                didFailWithError:&hideMagicButtonError];
        if (hideMagicButtonError != nil) {
            NSLog(@"Error hiding Magic button");
        } else {
            magicButtonShow = NO;
        }
    } else {
        NSError *displayMagicButtonError;
        [bubbles displayMagicButton:@"b51ddc997546f116df73b8deb39fcbca"
                      forController:self
                   didFailWithError:&displayMagicButtonError];
        if (displayMagicButtonError != nil) {
            NSLog(@"Error displaying Magic button");
        } else {
            magicButtonShow = YES;
        }
    }
    [_magicButtonLabel setText:[NSString stringWithFormat:@"Magic button currently %@", magicButtonShow ? @"ON" : @"OFF"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
