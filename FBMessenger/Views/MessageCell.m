//
//  FreindsCell.m
//  FBMessenger
//
//  Created by Gitesh Gawade on 22/10/16.
//  Copyright © 2016 Gitesh Gawade. All rights reserved.
//

#import "MessageCell.h"

@implementation MessageCell

-(Message *)getMessage
{
    return _message;
}

-(void)setMessage:(Message *)newMessage
{
    _message = newMessage;
    
    profileImageView.image = [UIImage imageNamed:_message.friend.profileImageName];
    hasReadImageView.image = [UIImage imageNamed:_message.friend.profileImageName];
    
    nameLabel.text = _message.friend.name;
    messageLabel.text = _message.text;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"h:mm a";
    timeLabel.text = [dateFormatter stringFromDate:_message.date];
    
}

-(void)initializeViews
{
    profileImageView = [[UIImageView alloc] init];
    profileImageView.translatesAutoresizingMaskIntoConstraints = false;
    profileImageView.layer.cornerRadius = 35;
    profileImageView.layer.masksToBounds = true;
    
    dividerLineView = [[UIView alloc] init];
    dividerLineView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    
    containerView = [[UIView alloc] init];
    
    nameLabel = [[UILabel alloc] init];
    nameLabel.translatesAutoresizingMaskIntoConstraints = false;
    nameLabel.font = [UIFont systemFontOfSize:18];
    
    messageLabel = [[UILabel alloc] init];
    messageLabel.translatesAutoresizingMaskIntoConstraints = false;
    messageLabel.textColor = [UIColor darkGrayColor];
    messageLabel.font = [UIFont systemFontOfSize:14];
    
    timeLabel = [[UILabel alloc] init];
    timeLabel.translatesAutoresizingMaskIntoConstraints = false;
    timeLabel.font = [UIFont systemFontOfSize:16];
    timeLabel.textAlignment = UITextAlignmentRight;
    
    hasReadImageView = [[UIImageView alloc] init];
    hasReadImageView.contentMode = UIViewContentModeScaleToFill;
    hasReadImageView.translatesAutoresizingMaskIntoConstraints = false;
    hasReadImageView.layer.cornerRadius = 15;
    hasReadImageView.layer.masksToBounds = true;
}

-(void)setupViews
{
    [self addSubview:profileImageView];
    [self addSubview:dividerLineView];
    
    [self addConstraintsWithFormat:@"H:|-12-[v0(68)]-2-[v1]|" onViews:@[profileImageView,dividerLineView]];
    [self addConstraintsWithFormat:@"V:|-16-[v0(68)]" onViews:@[profileImageView]];
    [self addConstraintsWithFormat:@"V:[v0(2)]|" onViews:@[dividerLineView]];
    
    [self setupContainerView];
}

-(void)setupContainerView
{
    [self addSubview:containerView];
    
    [containerView addSubview:nameLabel];
    [containerView addSubview:timeLabel];
    [containerView addSubview:messageLabel];
    [containerView addSubview:hasReadImageView];
    
    [self addConstraintsWithFormat:@"H:|-12-[v0]-5-[v1]|" onViews:@[profileImageView,containerView]];
    [self addConstraintsWithFormat:@"V:|[v0]|" onViews:@[containerView]];
    
    [containerView addConstraintsWithFormat:@"H:|-5-[v0]-5-[v1]-5-|" onViews:@[nameLabel,timeLabel]];
    [containerView addConstraintsWithFormat:@"H:|-5-[v0]-5-[v1(30)]-5-|" onViews:@[messageLabel,hasReadImageView]];
    [containerView addConstraintsWithFormat:@"V:|[v0(40)]-5-[v1]-5-|" onViews:@[nameLabel,messageLabel]];
    [containerView addConstraintsWithFormat:@"V:|[v0(40)]" onViews:@[timeLabel]];
    [containerView addConstraintsWithFormat:@"V:[v0(30)]-5-|" onViews:@[hasReadImageView]];
}
@end
