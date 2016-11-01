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
    NSManagedObjectContext *context;
    AppDelegate *delegate;
}
@end

@implementation FriendsController

static NSString * const cellId = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    context = delegate.managedObjectContext;
    
    // Register cell classes
    [self.collectionView registerClass:[MessageCell class] forCellWithReuseIdentifier:cellId];

    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.alwaysBounceVertical = true;
    
    [self setupData];
}

-(void)clearData
{
    NSError *error = nil;
    
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
    NSArray *friends = [self fetchFriends];
    if (friends.count != 0)
    {
        messages = [[NSMutableArray alloc] init];
        NSError *error = nil;

        for (Friend *friend in friends)
        {
            NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Message"];
            request.sortDescriptors =@[[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:false]];
            request.predicate = [NSPredicate predicateWithFormat:@"friend.name = %@", friend.name];
            request.fetchLimit = 1;
            
            @try {
               NSArray *fetchedRequest = (NSArray *)[context executeFetchRequest:request error:&error];
                [messages addObject:(Message *)fetchedRequest[0]];
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

    @try{
        NSArray *friendsArray = (NSArray *)[context executeFetchRequest:request error:&error];
        return friendsArray;
    } @catch (NSException *exception) {
        NSLog(@" Exception - %@", exception);
    }
    
    return nil;
}

// Setup data for the collectionview.
-(void)setupData
{
    NSError *error = nil;
    
    // Clear previous data so as to avoid duplication
    [self clearData];
 
  
    if (context != nil)
    {
        // Create Friends
        Friend *mark = (Friend *)[NSEntityDescription insertNewObjectForEntityForName:@"Friend" inManagedObjectContext:context];
        mark.name = @"Mark Zuckerberg";
        mark.profileImageName = @"zuckprofile";
        
        Friend *steve = (Friend *)[NSEntityDescription insertNewObjectForEntityForName:@"Friend" inManagedObjectContext:context];;
        steve.name = @"Steve Jobs";
        steve.profileImageName = @"steve_profile";
        
        Friend *donald = (Friend *)[NSEntityDescription insertNewObjectForEntityForName:@"Friend" inManagedObjectContext:context];
        donald.name = @"Donald Trump";
        donald.profileImageName = @"donald_trump_profile";

        // Create Messages for the friends
        [self createMessageWithText:@"Hi... this is Mark From FB" ofFriend:mark minutesAgo:5 context:context]; // Mark
        [self createMessageWithText:@"Good Morning ..." ofFriend:steve minutesAgo:5 context:context]; //  Steve
        [self createMessageWithText:@"How Are You ??" ofFriend:steve minutesAgo:2 context:context]; // Steve
        [self createMessageWithText:@"Apple manufactures smartest phones in the world !!" ofFriend:steve minutesAgo:0 context:context]; // Steve
        [self createMessageWithText:@"I wanna be next president !!!" ofFriend:donald minutesAgo:5 context:context];
        
        // Save the context to save the messages
        @try {
            [context save:&error];
        } @catch (NSException *exception) {
            
        }
        
        // Load the data to the messages array
        [self loadData];
    }
}


-(void)createMessageWithText:(NSString *)text ofFriend:(Friend *)friend minutesAgo:(double)minutesAgo context:(NSManagedObjectContext *)contextObj
{
    Message *message = (Message *)[NSEntityDescription insertNewObjectForEntityForName:@"Message" inManagedObjectContext:contextObj];
    message.text = text;
    message.date = [NSDate dateWithTimeIntervalSinceNow:-minutesAgo * 60];
    message.friend = friend;
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

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    ChatLogController *controller = [[ChatLogController alloc] initWithCollectionViewLayout:layout];
    controller.friend = [[messages objectAtIndex:indexPath.item] valueForKey:@"friend"];
    [self.navigationController pushViewController:controller animated:true];
}

@end