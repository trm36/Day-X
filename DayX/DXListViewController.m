//
//  DXListViewController.m
//  DayX
//
//  Created by Taylor Mott on 9.18.14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "DXListViewController.h"
#import "DXListTableViewDataSource.h"
#import "DetailViewController.h"
#import "ESEntryController.h"

@interface DXListViewController () <UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) DXListTableViewDataSource *dataSource;

@end

@implementation DXListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.tableView];
    
    self.title = @"Day-X";
    
    UIBarButtonItem *newEntryView = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(createNewEntryView)];
    self.navigationItem.rightBarButtonItem = newEntryView;
    
    self.dataSource = [DXListTableViewDataSource new];
    self.tableView.dataSource = self.dataSource;
    [self.dataSource registerTableView:self.tableView];
    
    self.tableView.delegate = self;
}

/*
 * Reload the data in the tableView to reflect updated saves
 *** MIGHT BE EXPENSIVE TO RELOAD EVERYTIME VIEW APPEARS, 
 *** FOR EXAMPLE IF YOU HAVE TABLE VIEWS THAT LOAD IMAGES FROM WEB
 */

- (void) viewDidAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

/*
 * function that gets called when plus (add) button in navigation bar is tapped
 * this creates a new detail (Entry) view controller and pushes it on top of view stack
 */

- (void)createNewEntryView
{
    DetailViewController *detailVC = [DetailViewController new];
    [self.navigationController pushViewController:detailVC animated:YES];
}

/*
 * is called when user selects a row
 * 1. deselects tableview row user tapped
 * 2. creates a new detail (entry) view 
 * 3. fills the detail from sharedInstance
 * 4. pushes view controller on top of view stack
 */

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DetailViewController *detailVC = [DetailViewController new];

    detailVC.entry = [ESEntryController sharedInstance].entries[indexPath.row];
    
    [self.navigationController pushViewController:detailVC animated:YES];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
