
//
//  FloorplanDetailViewController.m
//  MoLease
//
//  Created by Chris Voss on 2/19/11.
//  Copyright 2011 Chris Voss. All rights reserved.
//

#import "FloorplanDetailViewController.h"
#import "MoDataSource.h"
#import "MoTableViewController.h"

@implementation FloorplanDetailViewController

- (void)dealloc {
    TT_RELEASE_SAFELY(_floorplan);
    TT_RELEASE_SAFELY(_fpHeaderView);
    [super dealloc];
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

- (void)loadView { 
    [super loadView]; 
    
    self.tableView = [[[UITableView alloc] 
                       initWithFrame:self.view.bounds
                       style:UITableViewStyleGrouped] autorelease]; 
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | 
    UIViewAutoresizingFlexibleHeight; 
    [self.view addSubview:self.tableView]; 
} 

- (id)initWithNavigatorURL:(NSURL*)URL query:(NSDictionary*)query { 
    _hasBackgroundView = YES;
    
    TTDINFO(@"Incoming query: %@", [query description]);
	if (self == [super initWithNibName:nil bundle:NULL]){ 
        self.variableHeightRows = YES;
        _floorplan = [query retain];
        
        self.title = [_floorplan objectForKey:@"name"];
        
        float _width = 320/2;
        float _height = 480/2;
        NSString *_extension = @".png";
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            _extension = @"@iPad.png";
            _width = (768 * .5);
            _height = (1024 * .6);
        } 
            
        _fpHeaderView = [[TTImageView alloc] initWithFrame:CGRectMake(0, 0, _width, _height)];
        _fpHeaderView.contentMode = UIViewContentModeScaleAspectFit;
        [_fpHeaderView setUrlPath:[NSString stringWithFormat:@"bundle://%@.png", [_floorplan objectForKey:@"short"]]];
        self.tableView.tableHeaderView = _fpHeaderView;
    } 
	return self; 
}

#pragma -
#pragma TTModelViewController

- (void)createModel
{
    
    TTDINFO(@"Creating floorplan", nil);
    
    NSString *bedsString = NSLocalizedString(@"FLOORPLAN BEDROOMS FIELD", @"floorplan bedrooms field");
    NSString *bathsString = NSLocalizedString(@"FLOORPLAN BATHROOMS FIELD", @"floorplan bathrooms field");
    NSString *sqftString = NSLocalizedString(@"FLOORPLAN SQFT FIELD", @"floorplan sqft field");
    NSString *shareEmail = NSLocalizedString(@"FLOORPLAN SHARE EMAIL", @"floorplan share email");
    NSString *shareText = NSLocalizedString(@"FLOORPLAN SHARE TEXT", @"floorplan share text");
    NSString *shareMore = NSLocalizedString(@"FLOORPLAN SHARE MORE", @"floorplan share more");
    
    self.dataSource = [MoDataSource dataSourceWithItems:
                       [NSArray arrayWithObjects:
                        [NSArray arrayWithObjects:
                         [TTTableStyledTextItem itemWithText:[TTStyledText textFromXHTML:[NSString stringWithFormat:@"<div class=\"headerCell\">%@</div>", [_floorplan objectForKey:@"name"]]]],
                         [TTTableStyledTextItem itemWithText:[TTStyledText textFromXHTML:[NSString stringWithFormat:bedsString, [_floorplan objectForKey:@"bedrooms"]]]],
                         [TTTableStyledTextItem itemWithText:[TTStyledText textFromXHTML:[NSString stringWithFormat:bathsString, [_floorplan objectForKey:@"bathrooms"]]]],
                         [TTTableStyledTextItem itemWithText:[TTStyledText textFromXHTML:[NSString stringWithFormat:sqftString, [_floorplan objectForKey:@"sqft"]]]],
                         nil],
                        
                        [NSArray arrayWithObjects:
                         [TTTableButton itemWithText:shareEmail],
                         [TTTableButton itemWithText:shareText],
                         nil],
                        nil]
                                               sections:
                       [NSArray arrayWithObjects:@"", @"", nil]];
    
}

- (void)didSelectObject:(id)object atIndexPath:(NSIndexPath*)indexPath {
	
    NSString *shareEmail = NSLocalizedString(@"FLOORPLAN SHARE EMAIL", @"floorplan share email");
    NSString *shareText = NSLocalizedString(@"FLOORPLAN SHARE TEXT", @"floorplan share text");
    
    if ([object class] == [TTTableButton class]) {
        
        if ([[object text] isEqualToString:shareEmail]) {
            TTDINFO(@"email button pushed", nil);
            [self sendEmail];
        }
        
        if ([[object text] isEqualToString:shareText]) {
            TTDINFO(@"text button pushed", nil);
            [self sendText];
        }
        
    }
    
}

/** 
 * share floorplan by email
 */
- (void)sendEmail {
    TTDINFO(@"Showing email controller", nil);    
    MFMailComposeViewController *_mailController = [[MFMailComposeViewController alloc] init];
    [_mailController setMailComposeDelegate:self];  
    NSString *subjectString = NSLocalizedString(@"FLOORPLAN EMAIL SUBJECT", @"floorplan email subject");
    [_mailController setSubject:subjectString];
    
    NSString *bodyString = NSLocalizedString(@"FLOORPLAN EMAIL BODY", @"floorplan email body w/html");
    NSString *shareText = [NSString stringWithFormat:bodyString, 
                           [_floorplan objectForKey:@"name"], 
                           [_floorplan objectForKey:@"short_description"], 
                           [_floorplan objectForKey:@"url"]];
    
    [_mailController setMessageBody:shareText
                             isHTML:NO];
    [self presentModalViewController:_mailController animated:YES];
}

/**
 * share floorplan by SMS
 */
- (void)sendText {
    MFMessageComposeViewController *controller = [[[MFMessageComposeViewController alloc] init] autorelease];
	if([MFMessageComposeViewController canSendText])
	{
        NSString *smsString = NSLocalizedString(@"FLOORPLAN SMS BODY", @"floorplan sms body");
		controller.body =  [NSString stringWithFormat:smsString, 
                            [_floorplan objectForKey:@"name"], 
                            [_floorplan objectForKey:@"short_description"], 
                            [_floorplan objectForKey:@"url"]];
		controller.messageComposeDelegate = self;
		[self presentModalViewController:controller animated:YES];
	}
}


#pragma mark -
#pragma mark MFMailComposeViewControllerDelegate Methods

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    [controller dismissModalViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark MFMessageComposeViewController Methods

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    [controller dismissModalViewControllerAnimated:YES];
}




@end
