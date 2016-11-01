//
//  ChatLogMessageCell.m
//  FBMessenger
//
//  Created by Gitesh Gawade on 01/11/16.
//  Copyright © 2016 Gitesh Gawade. All rights reserved.
//

#import "ChatLogMessageCell.h"

@implementation ChatLogMessageCell


-(void)initializeViews
{
    _messageTextView = [[UITextView alloc] init];
    _messageTextView.font = [UIFont systemFontOfSize:18];
    _messageTextView.text = @"Sample Text";
}

-(void)setupViews
{
    [self addSubview:_messageTextView];
    
    
    [self addConstraintsWithFormat:@"H:|[v0]|" onViews:@[_messageTextView]];
    [self addConstraintsWithFormat:@"V:|[v0]|" onViews:@[_messageTextView]];
}

@end
