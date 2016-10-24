//
//  FreindsCell.h
//  FBMessenger
//
//  Created by Gitesh Gawade on 22/10/16.
//  Copyright © 2016 Gitesh Gawade. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCell.h"
#import "UIView+LayoutConstraints.h"
#import "FriendsControllerHelper.h"

@interface MessageCell : BaseCell
{
    UIImageView *profileImageView, *hasReadImageView;
    UILabel *nameLabel, *messageLabel, *timeLabel;
    UIView *dividerLineView, *containerView;
}

@property(nonatomic,strong) Message *message;

@end
