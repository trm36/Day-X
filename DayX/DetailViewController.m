//
//  DetailViewController.m
//  DayX
//
//  Created by Taylor Mott on 9.16.14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "DetailViewController.h"
#import "ESEntryController.h"

@interface DetailViewController () <UITextFieldDelegate, UITextViewDelegate>

@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UIButton *clearButton;
@property (strong, nonatomic) UIBarButtonItem * saveButton;
@property (strong, nonatomic) IBOutlet UILabel *charCountLabel;
@property (strong, nonatomic) IBOutlet UILabel *savedDateLabel;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Day X";
    
    self.saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(save)];
    self.navigationItem.rightBarButtonItem = self.saveButton;
    
    self.textField.delegate = self;
    //self.textView.backgroundColor = [UIColor colorWithRed:(227.0 / 255.0) green:(182.0 / 255.0) blue:(216.0 / 255.0) alpha:1.0];
    self.textView.delegate = self;
    if (self.entry != nil)
    {
        [self updateWithEntry];
    }
    
    [self updateCharCount];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 * Updates view with contents from a dictionary
 * More specifically the textField
 * More specifically the textView
 * More specifically the date Label
 */

- (void)updateWithEntry
{
    self.textField.text = self.entry.title;
    self.textView.text = self.entry.text;
    self.savedDateLabel.text = [@"Date Last Saved: " stringByAppendingString:self.entry.date];
}

/*
 * method to resign the keyboard from either the textField or textView,
 * doesn't matter if you are in one or the other, no error or exception
 */

- (void)hideKeyboard
{
    [self.textField resignFirstResponder];
    [self.textView resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self hideKeyboard];
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    [self updateCharCount];
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    [self hideKeyboard];
    return YES;
}

/*
 * function called when clear button is pressed and clears out the app title and description
 * but does not save
 */

- (IBAction)clearButtonPressed:(id)sender
{
    self.textField.text = @"";
    self.textView.text = @"";
}

/*
 * function to update character count of the text view
 */

- (void)updateCharCount
{
    self.charCountLabel.text = [NSString stringWithFormat:@"%ld", self.textView.text.length];
}

/* 
 * function that saves the all information in text view and field and updates save date which all get
 * stored in sharedInstance as a single dictionary.
 */

- (void)save
{
    [self hideKeyboard];
    
    NSString *dateString = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle];
    
    if (self.entry == nil)
    {
        [[ESEntryController sharedInstance] addEntryWithTitle:self.textField.text text:self.textView.text date:dateString];
    }
    else
    {
        self.entry.title = self.textField.text;
        self.entry.text = self.textView.text;
        self.entry.date = dateString;
        [[ESEntryController sharedInstance] synchronize];
    }
    
    self.savedDateLabel.text = [@"Date Last Saved: " stringByAppendingString:dateString];
    
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
