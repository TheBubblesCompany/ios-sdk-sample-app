//
//  ButtonLoading.m
//  Bubbles
//
//  Created by Pierre RACINE on 28/07/2015.
//  Copyright (c) 2015 AbsolutLabs. All rights reserved.
//

#import "ButtonLoading.h"

@interface ButtonLoading()
{
    UIActivityIndicatorView * _activityIndicatorView;
}

@end

@implementation ButtonLoading

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_activityIndicatorView setFrame:CGRectMake(self.frame.size.width/2.0 - 20.0/2.0, self.frame.size.height/2.0 - 20.0/2.0, 20, 20)];
}


- (void)setLoading:(BOOL)loading {
    if (self.loading != loading) {
        if (loading) {
            if (!_activityIndicatorView) {
                _activityIndicatorView = [[UIActivityIndicatorView alloc]
                                          initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
            }
            
            [_activityIndicatorView startAnimating];
            [self addSubview:_activityIndicatorView];
            [self.titleLabel setAlpha:0];
            
            [self setNeedsLayout];
        } else {
            
            [self.titleLabel setAlpha:1];
            [_activityIndicatorView stopAnimating];
            [_activityIndicatorView removeFromSuperview];
        }
    }
}

- (BOOL)isLoading {
    return [_activityIndicatorView isAnimating];
}

@end
