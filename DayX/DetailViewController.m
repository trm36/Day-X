//
//  DetailViewController.m
//  DayX
//
//  Created by Taylor Mott on 9.16.14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "DetailViewController.h"

static NSString *ideaTitleKey = @"ideaTitle";
static NSString *ideaDescriptionKey = @"ideaDescription";
static NSString *entryDictionaryKey = @"entryDictionary";
static NSString *saveDateKey = @"saveDate";

@interface DetailViewController () <UITextFieldDelegate, UITextViewDelegate>

@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UIButton *clearButton;
@property (strong, nonatomic) UIBarButtonItem * doneButton;
@property (strong, nonatomic) IBOutlet UIButton *saveButton;
@property (strong, nonatomic) IBOutlet UILabel *charCountLabel;
@property (strong, nonatomic) IBOutlet UILabel *savedDateLabel;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Day X";
    
    self.doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(hideKeyboard)];
    self.doneButton.tintColor = [UIColor grayColor];
    self.navigationItem.rightBarButtonItem = self.doneButton;
    
    self.textField.delegate = self;
    self.textView.backgroundColor = [UIColor colorWithRed:(227.0 / 255.0) green:(182.0 / 255.0) blue:(216.0 / 255.0) alpha:1.0];
    self.textView.delegate = self;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [self updateWithDictionary:[defaults objectForKey:entryDictionaryKey]];
    [self updateCharCount];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateWithDictionary:(NSDictionary *)dictionary
{
    self.textField.text = dictionary[ideaTitleKey];
    self.textView.text = dictionary[ideaDescriptionKey];
    self.savedDateLabel.text = [@"Date Last Saved: " stringByAppendingString:dictionary[saveDateKey]];
}

- (void)hideKeyboard
{
    [self.textField resignFirstResponder];
    [self.textView resignFirstResponder];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    self.doneButton.tintColor = [UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0];
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    self.doneButton.tintColor = [UIColor grayColor];
    [self save];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self hideKeyboard];
    self.doneButton.tintColor = [UIColor grayColor];
    return YES;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    self.doneButton.tintColor = [UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0];
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    [self updateCharCount];
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    self.doneButton.tintColor = [UIColor grayColor];
    [self save];
    return YES;
}

- (IBAction)clearButtonPressed:(id)sender
{
    self.textField.text = @"";
    self.textView.text = @"";
    [self save];
}

- (void)updateCharCount
{
    self.charCountLabel.text = [NSString stringWithFormat:@"%ld", self.textView.text.length];
}

- (void)save
{
    NSMutableDictionary *entry = [NSMutableDictionary new];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *dateString = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle];

    [entry setObject:dateString forKey:saveDateKey];
    [entry setObject:self.textField.text forKey:ideaTitleKey];
    [entry setObject:self.textView.text forKey:ideaDescriptionKey];
    
    [defaults setObject:entry forKey:entryDictionaryKey];
    
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
