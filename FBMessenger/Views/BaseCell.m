//
//  BaseCell.m
//  FBMessenger
//
//  Created by Gitesh Gawade on 22/10/16.
//  Copyright © 2016 Gitesh Gawade. All rights reserved.
//

#import "BaseCell.h"

@implementation BaseCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeViews];
        [self setupViews];
    }
    return self;
}

-(void)initializeViews
{
}

-(void)setupViews
{
    self.backgroundColor = [UIColor blueColor];
}

@end
