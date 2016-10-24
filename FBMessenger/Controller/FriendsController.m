//
//  FriendsController.m
//  FBMessenger
//
//  Created by Gitesh Gawade on 15/10/16.
//  Copyright © 2016 Gitesh Gawade. All rights reserved.
//

#import "FriendsController.h"

@interface FriendsController ()
{
    NSMutableArray *messages;
}
@end

@implementation FriendsController

static NSString * const cellId = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Register cell classes
    [self.collectionView registerClass:[MessageCell class] forCellWithReuseIdentifier:cellId];

    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.alwaysBounceVertical = true;
    
    [self setupData];
}

-(void)setupData
{
    messages = [[NSMutableArray alloc] init];
    
    Friend *mark = [[Friend alloc] init];
    mark.name = @"Mark Zuckerberg";
    mark.profileImageName = @"zuckprofile";
    
    Message *message = [[Message alloc] init];
    message.text = @"Hi... this is Mark From FB...";
    message.date = [[NSDate alloc] init];
    message.friend = mark;
    
    Friend *steve = [[Friend alloc] init];
    steve.name = @"Steve Jobs";
    steve.profileImageName = @"zuckprofile";
    
    Message *messageSteve = [[Message alloc] init];
    messageSteve.text = @"Hi... this is Steve From Apple...";
    messageSteve.date = [[NSDate alloc] init];
    messageSteve.friend = steve;

    
    [messages addObject:message];
    [messages addObject:messageSteve];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (messages.count != 0) {
        return messages.count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MessageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.message = [messages objectAtIndex:indexPath.item];
    
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.view.frame.size.width, 100);
}

@end


@implementation Friend

@synthesize name, profileImageName;

@end

@implementation Message

@synthesize text,date,friend;

@end