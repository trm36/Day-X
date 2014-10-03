//
//  ESEntryController.m
//  Entries
//
//  Created by Taylor Mott on 9.18.14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "ESEntryController.h"
#import "Stack.h"

static NSString *arrayKey = @"array";

@interface ESEntryController()

@end

@implementation ESEntryController

/*
 * Creates shared instance
 */

+ (ESEntryController *)sharedInstance
{
    static ESEntryController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ESEntryController alloc] init];

        
    });
    return sharedInstance;
}

/*
 * Adds dictionary to sharedInstance
 */

- (void)addEntryWithTitle:(NSString *)title text:(NSString *)text date:(NSString *)date
{
    Entry *entry = [NSEntityDescription insertNewObjectForEntityForName:@"Entry" inManagedObjectContext:[Stack sharedInstance].managedObjectContext];
    entry.title = title;
    entry.text = text;
    entry.date = date;
    
    [self synchronize];
}

/* 
 * removes given dictionary from entry if it exists
 */

- (void)removeEntry:(Entry *)entry
{
    //Both work, below line
    //[[Stack sharedInstance].managedObjectContext deleteObject:entry];
    
    //Safer for multiple Managed Object Contexts
    [entry.managedObjectContext deleteObject:entry];
    
    [self synchronize];
}


/*
 * forces ManagedObjectContext to save to Persistent Story to synchronize
 */

- (void)synchronize
{
    [[Stack sharedInstance].managedObjectContext save:nil];
}

- (NSArray *)entries
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Entry"];
    NSArray *entries = [[Stack sharedInstance].managedObjectContext executeFetchRequest:request error:nil];
    
    return entries;
}

@end
