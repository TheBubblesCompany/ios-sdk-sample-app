//
//  ServicesTableViewController.h
//  BubblesTwo
//
//  Created by Karim Koriche on 13/12/2016.
//  Copyright © 2016 Absolutlabs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface ServicesTableViewController : UITableViewController


@property (strong, nonatomic) ViewController * VC;

@property (strong, nonatomic) NSMutableDictionary * services;


@end
