//
//  FreindsCell.m
//  FBMessenger
//
//  Created by Gitesh Gawade on 22/10/16.
//  Copyright © 2016 Gitesh Gawade. All rights reserved.
//

#import "FriendsCell.h"

@implementation FriendsCell

-(void)initializeViews
{
    self.backgroundColor = [UIColor cyanColor];
    
    profileImageView = [[UIImageView alloc] init];
    profileImageView.translatesAutoresizingMaskIntoConstraints = false;
    profileImageView.image = [UIImage imageNamed:@"zuckprofile"];
    profileImageView.backgroundColor = [UIColor grayColor];
    profileImageView.layer.cornerRadius = 35;
    profileImageView.layer.masksToBounds = true;
    
    dividerLineView = [[UIView alloc] init];
    dividerLineView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    
    containerView = [[UIView alloc] init];
    containerView.backgroundColor = [UIColor lightGrayColor];
    
    nameLabel = [[UILabel alloc] init];
    nameLabel.text = @"Mark Zuckerberg";
    nameLabel.font = [UIFont systemFontOfSize:18];
    
    messageLabel = [[UILabel alloc] init];
    messageLabel.text = @"Your friend's message and something else...";
    messageLabel.textColor = [UIColor darkGrayColor];
    messageLabel.font = [UIFont systemFontOfSize:14];

    timeLabel = [[UILabel alloc] init];
    timeLabel.text = @"12:05 pm";
    timeLabel.font = [UIFont systemFontOfSize:16];
    timeLabel.textAlignment = UITextAlignmentRight;
    
    hasReadImageView = [[UIImageView alloc] init];
    hasReadImageView.contentMode = UIViewContentModeScaleToFill;
    hasReadImageView.layer.cornerRadius = 10;
    hasReadImageView.layer.masksToBounds = true;
}

-(void)setupViews
{
    [self addSubview:profileImageView];
    [self addSubview:dividerLineView];
    
    [self addConstraintsWithFormat:@"H:|-12-[v0(68)]" onViews:@[profileImageView]];
    [self addConstraintsWithFormat:@"V:|-16-[v0(68)]" onViews:@[profileImageView]];
    
    [self setupContainerView];
}

-(void)setupContainerView
{
    [self addSubview:containerView];
    
#warning Need to setup these views
//    [containerView addSubview:nameLabel];
//    [containerView addSubview:messageLabel];
//    [containerView addSubview:timeLabel];
//    [containerView addSubview:hasReadImageView];

    
    [self addConstraintsWithFormat:@"H:|-12-[v0]-5-[v1]|" onViews:@[profileImageView,containerView]];
    [self addConstraintsWithFormat:@"V:|[v0]|" onViews:@[containerView]];

}

@end
