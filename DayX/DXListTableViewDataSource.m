//
//  DXListTableViewDatasource.m
//  DayX
//
//  Created by Taylor Mott on 9.18.14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "DXListTableViewDataSource.h"
#import "ESEntryController.h"
#import "DetailViewController.h"

static NSString *CELL = @"cell";

@implementation DXListTableViewDataSource

/*
 * Registers table view
 */

- (void)registerTableView:(UITableView *)tableView
{
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CELL];
}

/*
 * REQUIRED METHOD OF TABLEVIEWDATASOURCE
 * Sets name of each table view cell
 */

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL];
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CELL];
    
    Entry *entry = [ESEntryController sharedInstance].entries[indexPath.row];
    
    //Check if string is empty or only has white space
    if ([[entry.title stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0)
    {
        cell.textLabel.text = @"(blank)";
        cell.textLabel.textColor = [UIColor grayColor];
    }
    else
    {
        cell.textLabel.text = entry.title;
        cell.textLabel.textColor = [UIColor blackColor];
    }
    
    cell.detailTextLabel.text = entry.text;
    cell.detailTextLabel.textColor = [UIColor grayColor];
    UIFontDescriptor *fontDescriptor = [cell.detailTextLabel.font.fontDescriptor fontDescriptorWithSymbolicTraits:UIFontDescriptorTraitItalic];
    //Size 0 keeps size as is
    cell.detailTextLabel.font = [UIFont fontWithDescriptor:fontDescriptor size:0];
    cell.detailTextLabel.numberOfLines = 1;
    
    return cell;
}

/*
 * REQUIRED METHOD OF TABLEVIEWDATASOURCE
 * sets the number of rows in the tableView
 */

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [ESEntryController sharedInstance].entries.count;
}

@end
