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

-(void)clearData
{
    NSError *error = nil;
    
    NSArray *entityNames = @[@"Friend",@"Message"];
    for (NSString *entityName in entityNames) {
        NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:entityName];
        NSArray *objects = [context executeFetchRequest:request error:&error];
        
        for (NSManagedObject *object in objects) {
            @try {
                [context delete:object];
            }
            @catch (NSException *exception) {
                NSLog(@"%@",exception);
            }
        }
    }
    [context save:&error];
}

-(void)loadData
{
    NSError *error = nil;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Message"];
    @try {
        messages = (NSMutableArray *)[context executeFetchRequest:request error:&error];
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
}

-(void)setupData
{
    messages = [[NSMutableArray alloc] init];
    // Clear previous data so as to avoid duplication
    [self clearData];
 
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    context = delegate.managedObjectContext;
  
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
        steve.profileImageName = @"zuckprofile";
        
        Message *messageSteve = (Message *)[NSEntityDescription insertNewObjectForEntityForName:@"Message" inManagedObjectContext:context];
        messageSteve.text = @"Hi... this is Steve From Apple...";
        messageSteve.date = [[NSDate alloc] init];
        messageSteve.friend = steve;
        
//        [messages addObject:message];
//        [messages addObject:messageSteve];
        
        [self loadData];
    }
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