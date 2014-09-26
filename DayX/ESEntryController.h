//
//  ESEntryController.h
//  Entries
//
//  Created by Taylor Mott on 9.18.14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ESEntryController : NSObject

@property (nonatomic, strong, readonly) NSArray *entries;

+ (ESEntryController *)sharedInstance;
- (void)addEntry:(NSDictionary *)entry;
- (void)removeEntry:(NSDictionary *)entry;
- (void)replaceEntry:(NSDictionary *)oldEntry withEntry:(NSDictionary *)newEntry;

@end
