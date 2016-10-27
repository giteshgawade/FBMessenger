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
    AppDelegate *delegate;
}
@end

@implementation FriendsController

static NSString * const cellId = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    // Register cell classes
    [self.collectionView registerClass:[MessageCell class] forCellWithReuseIdentifier:cellId];

    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.alwaysBounceVertical = true;
    
    [self setupData];
}

-(void)clearData
{
    NSError *error = nil;

    NSManagedObjectContext *context = delegate.managedObjectContext;

    NSArray *entityNames = @[@"Friend",@"Message"];
    for (NSString *entityName in entityNames) {
        NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:entityName];
        NSArray *objects = [context executeFetchRequest:request error:&error];
        
        for (NSManagedObject *object in objects) {
            @try {
                [context deleteObject:object];
            }
            @catch (NSException *exception) {
                NSLog(@"Delete Exception - %@",exception);
            }
        }
    }
    if ([context save:&error] == NO) {
        NSAssert(NO, @"Error saving context: %@\n%@", [error localizedDescription], [error userInfo]);
    }
}

-(void)loadData
{
    NSError *error = nil;
    messages = [[NSMutableArray alloc] init];

    NSManagedObjectContext *context = delegate.managedObjectContext;


    NSArray *friends = [self fetchFriends];
    if (friends.count != 0)
    {
        for (Friend *friend in friends)
        {
            NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Message"];
            messages = (NSMutableArray *)[context executeFetchRequest:request error:&error];
            request.sortDescriptors =@[[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:false]];
            request.predicate = [NSPredicate predicateWithFormat:@"friend.name = %@", friend.name];
            request.fetchLimit = 1;
            @try {
                NSArray *fetchedRequest = (NSArray *)[context executeFetchRequest:request error:&error];
                Message *msg = fetchedRequest[0];
                NSLog(@"Text = %@",msg.text);
                [messages addObject:fetchedRequest];
//                messages = (NSMutableArray *)[context executeFetchRequest:request error:&error];
            }
            @catch (NSException *exception) {
                NSLog(@"%@",exception);
            }
        }
    }
}

-(NSArray *)fetchFriends
{
    NSError *error = nil;
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Friend"];
    NSManagedObjectContext *context = delegate.managedObjectContext;

    @try{
        NSArray *friendsArray = (NSArray *)[context executeFetchRequest:request error:&error];
        return friendsArray;
    } @catch (NSException *exception) {
        NSLog(@" Exception - %@", exception);
    }
    
    return nil;
}

-(void)setupData
{
    NSError *error = nil;
    
    NSManagedObjectContext *context = delegate.managedObjectContext;
    // Clear previous data so as to avoid duplication
    [self clearData];
 
  
    if (context != nil)
    {
        Friend *mark = (Friend *)[NSEntityDescription insertNewObjectForEntityForName:@"Friend" inManagedObjectContext:context];
        mark.name = @"Mark Zuckerberg";
        mark.profileImageName = @"zuckprofile";
        
        Message *message = (Message *)[NSEntityDescription insertNewObjectForEntityForName:@"Message" inManagedObjectContext:context];
        message.text = @"Hi... this is Mark From FB...";
        message.date = [[NSDate alloc] init];
        message.friend = mark;
        
        Friend *steve = (Friend *)[NSEntityDescription insertNewObjectForEntityForName:@"Friend" inManagedObjectContext:context];;
        steve.name = @"Steve Jobs";
        steve.profileImageName = @"steve_profile";

        
        [self createMessageWithText:@"Good Morning ..." ofFriend:steve minutesAgo:5 context:context];
        [self createMessageWithText:@"How Are You ??" ofFriend:steve minutesAgo:2 context:context];
        [self createMessageWithText:@"Apple manufactures smartest phones in the world !!" ofFriend:steve minutesAgo:0 context:context];
        
        @try {
            [context save:&error];
        } @catch (NSException *exception) {
            
        }
        
        [self loadData];
    }
}


-(void)createMessageWithText:(NSString *)text ofFriend:(Friend *)friend minutesAgo:(double)minutesAgo context:(NSManagedObjectContext *)contextObj
{
    Message *messageSteve = (Message *)[NSEntityDescription insertNewObjectForEntityForName:@"Message" inManagedObjectContext:contextObj];
    messageSteve.text = text;
    messageSteve.date = [NSDate dateWithTimeIntervalSinceNow:-minutesAgo * 60];
    messageSteve.friend = friend;
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