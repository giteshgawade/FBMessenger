//
//  ChatLogController.h
//  FBMessenger
//
//  Created by Gitesh Gawade on 01/11/16.
//  Copyright © 2016 Gitesh Gawade. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Friend.h"
#import "ChatLogMessageCell.h"

@interface ChatLogController : UICollectionViewController<UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong) Friend *friend;

@end
