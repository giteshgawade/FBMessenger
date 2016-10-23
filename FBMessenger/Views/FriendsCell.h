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

@interface FriendsCell : BaseCell
{
    UIImageView *profileImageView, *hasReadImageView;
    UILabel *nameLabel, *messageLabel, *timeLabel;
    UIView *dividerLineView, *containerView;
}

@end
