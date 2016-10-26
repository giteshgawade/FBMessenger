//
//  Message+CoreDataProperties.h
//  FBMessenger
//
//  Created by Gitesh Gawade on 26/10/16.
//  Copyright © 2016 Gitesh Gawade. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Message.h"

NS_ASSUME_NONNULL_BEGIN

@interface Message (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *text;
@property (nullable, nonatomic, retain) NSDate *date;
@property (nullable, nonatomic, retain) Friend *friend;

@end

NS_ASSUME_NONNULL_END
