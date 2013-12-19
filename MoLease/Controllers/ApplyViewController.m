//
//  ApplyViewController.m
//  MoLease
//
//  Created by Chris Voss on 2/22/11.
//  Copyright 2011 Chris Voss. All rights reserved.
//

#import "ApplyViewController.h"
#import "MoDataSource.h"
#import "MoTableViewController.h"


@implementation ApplyViewController

- (void)loadView { 
    [super loadView]; 
    self.tableView = [[[UITableView alloc] 
                       initWithFrame:self.view.bounds
                       style:UITableViewStyleGrouped] autorelease]; 
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | 
    UIViewAutoresizingFlexibleHeight; 
    [self.view addSubview:self.tableView];
}

//fixes header image going under status bar under in iOS7
- (void) viewDidLayoutSubviews {
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
        
    } else {
        self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
        if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
            self.edgesForExtendedLayout = UIRectEdgeNone;   // iOS 7 specific
        CGRect viewBounds = self.view.bounds;
        CGFloat topBarOffset = self.topLayoutGuide.length;
        viewBounds.origin.y = topBarOffset * -1;
        self.view.bounds = viewBounds;
        self.navigationController.navigationBar.translucent = YES;
    }
}

- (void)dealloc {
    TT_RELEASE_SAFELY(_nameField);
    TT_RELEASE_SAFELY(_emailField);
    TT_RELEASE_SAFELY(_cellField);
    TT_RELEASE_SAFELY(_specialNotes);
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    _hasBackgroundView = YES;
    _hasHeaderView = YES;
    _headerURL = @"bundle://header_apply%@";
    
    if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        TTDINFO(@"Initializing Apply View Controller", nil);
        self.title = NSLocalizedString(@"APPLY TITLE", @"apply title");
        self.autoresizesForKeyboard = YES;
    }
    return self;
}


#pragma -
#pragma TTModelViewController

- (void)createModel
{
    
    TTDINFO(@"Creating Apply view controller", nil);
    
    // TODO: autorelease will cause problems?
    
    _nameField = [[UITextField alloc] init];
    _nameField.placeholder = NSLocalizedString(@"NAME PLACEHOLDER", @"name placeholder");
    _nameField.delegate = self;
    _nameField.returnKeyType = UIReturnKeyNext;
    _nameField.autocapitalizationType = UITextAutocapitalizationTypeWords;
    _nameField.autocorrectionType = UITextAutocorrectionTypeNo;    
    TTTableControlItem *_nameItem = [TTTableControlItem itemWithCaption:NSLocalizedString(@"NAME FIELD", @"name field") 
                                                                control:_nameField];
    
    _emailField = [[UITextField alloc] init];
    _emailField.placeholder = NSLocalizedString(@"EMAIL PLACEHOLDER", @"email placeholder");;
    _emailField.keyboardType = UIKeyboardTypeEmailAddress;
    _emailField.autocorrectionType = UITextAutocorrectionTypeNo;
    _emailField.delegate = self;
    _emailField.returnKeyType = UIReturnKeyNext;
    TTTableControlItem *_emailItem = [TTTableControlItem itemWithCaption:NSLocalizedString(@"EMAIL FIELD", @"email field") 
                                                                 control:_emailField];
    
    _cellField = [[UITextField alloc] init];
    _cellField.keyboardType = UIKeyboardTypePhonePad;
    _cellField.placeholder = NSLocalizedString(@"PHONE PLACEHOLDER", @"phone placeholder");;
    _cellField.delegate = self;
    _cellField.autocorrectionType = UITextAutocorrectionTypeNo;
    _cellField.returnKeyType = UIReturnKeyNext;
    TTTableControlItem *_cellItem = [TTTableControlItem itemWithCaption:NSLocalizedString(@"PHONE FIELD", @"phone field") 
                                                                control:_cellField];
    
    _specialNotes = [[UITextField alloc] init];
    _specialNotes.delegate = self;
    _specialNotes.placeholder = NSLocalizedString(@"NOTES PLACEHOLDER", @"notes placeholder");
    _specialNotes.autocorrectionType = UITextAutocorrectionTypeNo;
    _specialNotes.returnKeyType = UIReturnKeyDone;
    
    TTTableControlItem *_notesItem = [TTTableControlItem itemWithCaption:NSLocalizedString(@"NOTES FIELD", @"notes field") 
                                                                 control:_specialNotes];
    
    _phoneField = [[UITextField alloc] init];
    _phoneField.text = @"      866.245.8759";
    _phoneField.enabled = NO;
    
    _addressField1 = [[UITextField alloc] init];
    _addressField1.text = @" 4905 Ashley Park Lane";
    _addressField1.enabled = NO;
    
    _addressField2 = [[UITextField alloc] init];
    _addressField2.text = @"    Charlotte, NC 28210";
    _addressField2.enabled = NO;
        
    TTTableControlItem *_phoneFieldItem = [TTTableControlItem itemWithCaption:@"PHONE: "
                                                                control:_phoneField];
    TTTableControlItem *_addressFieldItem = [TTTableControlItem itemWithCaption:@"ADDRESS: "
                                                                      control:_addressField1];
    TTTableControlItem *_addressField2Item = [TTTableControlItem itemWithCaption:@"                " 
                                                                        control:_addressField2];


    
    self.dataSource = [MoDataSource dataSourceWithItems:
                       
                       [NSArray arrayWithObjects:
                        // GENERAL INFORMATION
                        [NSArray arrayWithObjects:
                         [TTTableStyledTextItem itemWithText:
                          [TTStyledText textFromXHTML:NSLocalizedString(@"APPLY TABLE TITLE", @"apply table section title w/html")]],
                         _nameItem, _emailItem,_cellItem,_notesItem,
                         nil],
                        // NEXT STEPS
                        [NSArray arrayWithObjects:
                         [TTTableButton itemWithText:NSLocalizedString(@"EMAIL BUTTON", @"email button")],
                         nil],
                       // CONTACT INFO
                       [NSArray arrayWithObjects:
                        [TTTableStyledTextItem itemWithText:
                         [TTStyledText textFromXHTML:@"<div class=\"headerCell\">CONTACT SOLIS SHARON SQUARE</div>"]],
                        _phoneFieldItem, _addressFieldItem, _addressField2Item, nil],
                        nil]

                                               sections:
                       [NSArray arrayWithObjects:@"",@"", @"", nil]];
    
}

- (void)didSelectObject:(id)object atIndexPath:(NSIndexPath*)indexPath {	
    
    if ([object class] == [TTTableButton class]) {
        TTDINFO(@"email button pushed", nil);
        [self sendEmail];
    }
    
}

/**
 * launch email controller
 */
- (void)sendEmail {
    TTDINFO(@"Showing email controller", nil);    
    
    MFMailComposeViewController *_mailController = [[[MFMailComposeViewController alloc] init] autorelease];
    [_mailController setMailComposeDelegate:self];        
    [_mailController setToRecipients:
     [NSArray arrayWithObject:NSLocalizedString(@"EMAIL ADDRESS", @"client email address")]];
    
    [_mailController setSubject:NSLocalizedString(@"EMAIL SUBJECT", @"email subject")];
    
    NSString *emailBody = NSLocalizedString(@"EMAIL BODY", @"email body w/html");
    NSString *applicationString = [NSString stringWithFormat:@"%@<br />%@ (<a href='mailto:%@'>email</a>)<br />%@<br />%@",
                                   emailBody,
                                   [_nameField text],
                                   [_emailField text],
                                   [_cellField text],
                                   [_specialNotes text]];
    
    [_mailController setMessageBody:applicationString
                             isHTML:YES];
    [self presentModalViewController:_mailController animated:YES];
}

#pragma mark - MFMailComposeViewControllerDelegate Methods

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    [controller dismissModalViewControllerAnimated:YES];
}

#pragma mark - textField delegate


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([_cellField isFirstResponder]) {
        [_specialNotes becomeFirstResponder];
    }
    if ([_emailField isFirstResponder]) {
        [_cellField becomeFirstResponder];
    }
    if ([_nameField isFirstResponder]) {
        [_emailField becomeFirstResponder];
    }
    if ([_specialNotes isFirstResponder]) {
        [textField resignFirstResponder];
    }
    
    return YES;
}
@end
