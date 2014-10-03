//
//  ESEntryController.h
//  Entries
//
//  Created by Taylor Mott on 9.18.14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Entry.h"

@interface ESEntryController : NSObject

+ (ESEntryController *)sharedInstance;
- (void)addEntryWithTitle:(NSString *)title text:(NSString *)text date:(NSString *)date;
- (void)removeEntry:(Entry *)entry;
- (NSArray *)entries;
- (void)synchronize;

@end
