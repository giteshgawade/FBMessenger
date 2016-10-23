//
//  UIView+LayoutConstraints.m
//  YoutubeObjc
//
//  Created by Gitesh Gawade on 25/09/16.
//  Copyright © 2016 Gitesh Gawade. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "UIView+LayoutConstraints.h"

@implementation UIView (LayoutConstraints)

-(void)addConstraintsWithFormat:(NSString *)format onViews:(NSArray *)views
{
    NSMutableDictionary * viewsDictionary = [[NSMutableDictionary alloc] initWithCapacity:[views count]];
    
    int i = 0;
    for(UIView* view in views)
    {
        view.translatesAutoresizingMaskIntoConstraints = NO;
//        [viewsDictionary setValue:view forKey:[@"v" stringByAppendingString:[NSString stringWithFormat:@"%d",i]]];
        [viewsDictionary setObject:view forKey:[@"v" stringByAppendingString:[NSString stringWithFormat:@"%d",i]]];
        i++;
    }
    // Ref Code for DIctionary creation === Ref: http://stackoverflow.com/questions/12864990/nslayoutconstraints-and-setting-the-width-height-of-a-view-dynamically ============
    
//    self.containerView = [[HitTestContainerView alloc] init];
//    [self.containerView setBackgroundColor:[UIColor redColor]];
//    [self.view addSubview:self.containerView];
//    
//    NSDictionary *viewsDictionary = @{@"view":self.containerView};
    
//    NSArray *verticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-50-[view]-250-|" options:0 metrics:nil views:viewsDictionary];
//    NSArray *horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0 metrics:nil views:viewsDictionary];
//    [self.view addConstraints:verticalConstraints];
//    [self.view addConstraints:horizontalConstraints];
    // =========================================================
    
    
    // Check for the answer thread of the above reference link
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:nil views:viewsDictionary]];
}

@end
