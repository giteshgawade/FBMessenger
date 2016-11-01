//
//  ChatLogController.m
//  FBMessenger
//
//  Created by Gitesh Gawade on 01/11/16.
//  Copyright © 2016 Gitesh Gawade. All rights reserved.
//

#import "ChatLogController.h"

@interface ChatLogController ()
{
    NSArray<Message *> *messages;
}
@end

@implementation ChatLogController

static NSString * const cellId = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Register cell classes
    [self.collectionView registerClass:[ChatLogMessageCell class] forCellWithReuseIdentifier:cellId];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(Friend *)getFriend
{
    return _friend;
}

-(void)setFriend:(Friend *)friend
{
    _friend = friend;
    self.navigationItem.title = _friend.name;

    messages = [_friend.messages allObjects];
    for(Message *message in messages)
    {
        NSLog(@"Msg = %@", message.text);
    }
}


#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (messages.count != 0) {
        return messages.count;
    }
    
    return 0;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.view.frame.size.width, 100);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ChatLogMessageCell *cell = (ChatLogMessageCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    Message *msg = [messages objectAtIndex:indexPath.item];
//    cell.messageTextView.text = [[messages objectAtIndex:indexPath.item] valueForKey:@"text"];
    cell.backgroundColor = [UIColor blueColor];
    
    return cell;
}

@end
