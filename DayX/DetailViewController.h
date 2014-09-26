//
//  DetailViewController.h
//  DayX
//
//  Created by Taylor Mott on 9.16.14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *ideaTitleKey = @"ideaTitle";
static NSString *ideaDescriptionKey = @"ideaDescription";
static NSString *entryDictionaryKey = @"entryDictionary";
static NSString *saveDateKey = @"saveDate";

@interface DetailViewController : UIViewController

@property (strong, nonatomic) NSDictionary *dictionary;
- (void)updateWithDictionary;

@end
