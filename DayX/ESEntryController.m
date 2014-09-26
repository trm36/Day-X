//
//  ESEntryController.m
//  Entries
//
//  Created by Taylor Mott on 9.18.14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "ESEntryController.h"

static NSString *arrayKey = @"array";

@interface ESEntryController()

@property (nonatomic, strong) NSArray *entries;

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
        sharedInstance.entries = @[];
        [sharedInstance loadFromDefaults];
    });
    return sharedInstance;
}

/*
 * Adds dictionary to sharedInstance
 */


- (void)addEntry:(NSDictionary *)entry
{
    self.entries = [self.entries arrayByAddingObject:entry];
    
    [self synchronize];
}

/* 
 * removes given dictionary from entry if it exists
 */

- (void)removeEntry:(NSDictionary *)entry
{
    NSMutableArray *mutableEntries = [self.entries mutableCopy];
    
    [mutableEntries removeObject:entry];
    
    self.entries = [mutableEntries copy];
    
    [self synchronize];
}

/*
 * updates oldEntry with newEntry if oldEntry exists
 */

- (void)replaceEntry:(NSDictionary *)oldEntry withEntry:(NSDictionary *)newEntry;
{
    if ([self.entries containsObject:oldEntry])
    {
        NSMutableArray *mutableEntries = [self.entries mutableCopy];
        
        [mutableEntries replaceObjectAtIndex:[mutableEntries indexOfObject:oldEntry] withObject:newEntry];
        
        self.entries = [mutableEntries copy];
        
        [self synchronize];
    }
}

/*
 *
 */

- (void)loadFromDefaults
{
    NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:arrayKey];
    
    if(array)
    {
        self.entries = array;
    }
}

/*
 * forces NSUserDefaults to synchronize
 */

- (void)synchronize
{
    [[NSUserDefaults standardUserDefaults] setObject:self.entries forKey:arrayKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
