//
//  ServicesTableViewController.m
//  Bubbles SDK Sample
//
//  Created by Karim Koriche on 13/12/2016.
//  Copyright © 2017 Bubbles Company.  All rights reserved.
//

#import "ServicesTableViewController.h"
#import <Bubbles/Bubbles.h>

@interface ServicesTableViewController ()

@end

@implementation ServicesTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.bounces = NO;
}

-(void)closeListe
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[_services objectForKey:@"service"] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CGRect frame = tableView.frame;
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    headerView.backgroundColor = [UIColor blackColor];
    
    UIButton * closeButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 25, 30, 30)];
    [closeButton setImage:[UIImage imageNamed:@"closeButton"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(closeListe) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(70, 10, headerView.frame.size.width - 140, 60)];
    title.text = @"Service list";
    [title setTextAlignment:NSTextAlignmentCenter];
    title.textColor = [UIColor whiteColor];
    [title setFont:[UIFont boldSystemFontOfSize:17]];
    
    [headerView addSubview:title];
    [headerView addSubview:closeButton];
    
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    
    }
    else
    {
        for (UIView * view in cell.subviews)
        {
            [view removeFromSuperview];
        }
    }
    
    cell.backgroundColor = self.view.backgroundColor;
    
        NSMutableArray * ar = [_services objectForKey:@"service"];
    
        NSMutableDictionary * service = [ar objectAtIndex:indexPath.row];
        
        UIImageView * imgService = [UIImageView new];
        imgService.frame = CGRectMake(5, 5, 80, 80);
        imgService.alpha = 0;
        [cell addSubview:imgService];
        
        UILabel * serviceName = [[UILabel alloc] initWithFrame:CGRectMake(90, 5, 300, 30)];
        [serviceName setText:[service objectForKey:@"name"]];
        serviceName.textColor = [UIColor whiteColor];
        [serviceName setFont:[UIFont boldSystemFontOfSize:17]];
        [cell addSubview:serviceName];
        
        UILabel * serviceId = [[UILabel alloc] initWithFrame:CGRectMake(90, 30, 300, 30)];
        [serviceId setText:[service objectForKey:@"id"]];
        serviceId.textColor = [UIColor whiteColor];
        [serviceId setFont:[UIFont italicSystemFontOfSize:13]];
        [cell addSubview:serviceId];
        
        UILabel * serviceDescription = [[UILabel alloc] initWithFrame:CGRectMake(90, 50, 300, 30)];
        [serviceDescription setText:[service objectForKey:@"description"]];
        serviceDescription.textColor = [UIColor whiteColor];
        [serviceDescription setFont:[UIFont systemFontOfSize:13]];
        [cell addSubview:serviceDescription];
        NSString * imageURL = [service objectForKey:@"picto_splashscreen"];
        
        if(imageURL)
        {
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
            dispatch_async(queue, ^(void) {
                
                NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
                UIImage* image = [[UIImage alloc] initWithData:imageData];
                
                if (image) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [imgService setImage:image];
                        
                        [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                            imgService.alpha = 1.0;
                        } completion:nil];
                        
                    });
                }
            });
        }
    
    return cell;
}



-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray * ar = [_services objectForKey:@"service"];
    
    NSMutableDictionary * service = [ar objectAtIndex:indexPath.row];
    
    _VC.currentServiceName = [service objectForKey:@"name"];
    _VC.currentServiceId = [service objectForKey:@"id"];
    _VC.currentFullscreenMode = [NSNumber numberWithInt:[[service objectForKey:@"fullscreen"] intValue]];
    
    [self dismissViewControllerAnimated:YES completion:^{
             [_VC serviceSelected];
    }];
}



@end
