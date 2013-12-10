//
//  SocialViewController.m
//  MoLease
//
//  Created by Chris Voss on 2/19/11.
//  Copyright 2011 Chris Voss. All rights reserved.
//

#import "LinksViewController.h"
#import "MoDataSource.h"
#import "MoTableViewController.h"

@implementation LinksViewController

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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    _path = nil;
    _hasHeaderView = YES;
    if (_headerURL == nil) _headerURL = @"bundle://header_links%@";
    _hasBackgroundView = YES;
    if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        TTDINFO(@"Initializing Links View Controller", nil);
        self.title = NSLocalizedString(@"LINKS TITLE", @"links title");
    }
    return self;
}

- (id)initWithPath:(NSString *)path {
    _headerURL = @"bundle://header_news%@";

    self = [self initWithNibName:nil
                          bundle:nil];
    if (self) {
        self.title = NSLocalizedString(@"NEWS TITLE", @"news title");
        _path = [path retain];
    }
    return self;
}

#pragma -
#pragma TTModelViewController

- (void)createModel
{
    NSMutableArray *sectionsArray = [NSMutableArray array];
    NSMutableArray *itemsArray = [NSMutableArray array];
    
    NSString *pathString = @"links";
    if (_path != nil) pathString = _path;
    NSArray *linksArray = [[NSArray alloc] initWithContentsOfFile:
                           [[NSBundle mainBundle] pathForResource:pathString
                                                           ofType:@"plist"]];
    
    for (NSDictionary *sectionDictionary in [linksArray objectAtIndex:0]) {
        NSString *sectionTitle = [NSString stringWithFormat:@"<div class=\"headerCell\">%@</div>",
                                  [sectionDictionary objectForKey:@"title"]];
        [sectionsArray addObject:@""];
        
        NSMutableArray *subItems = [NSMutableArray array];
        [subItems addObject:[TTTableStyledTextItem itemWithText:[TTStyledText textFromXHTML:sectionTitle]]];
        
        for (NSDictionary *linkDictionary in [sectionDictionary objectForKey:@"links"]) {
            [subItems addObject:
             [TTTableTextItem itemWithText:[linkDictionary objectForKey:@"name"] 
                                       URL:[linkDictionary objectForKey:@"url"]]];
            
        }
        [itemsArray addObject:subItems];
    }
    
    self.dataSource = [MoDataSource dataSourceWithItems:itemsArray
                                               sections:sectionsArray];
    TT_RELEASE_SAFELY(linksArray);
    
}

@end
