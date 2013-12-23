//
//  FeaturesViewController.m
//  MoLease
//
//  Created by Chris Voss on 4/12/11.
//  Copyright 2011 Chris Voss. All rights reserved.
//
#import "FeaturesViewController.h"

@implementation FeaturesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    _hasHeaderView = YES;
    _headerURL = @"bundle://header_features%@";
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
        self.title = NSLocalizedString(@"FEATURES TITLE", @"features title");
        self.variableHeightRows = YES;
    }
    return self;
}

// Changes color of separators
- (void)viewDidLoad
{
    [self.tableView setSeparatorColor:[UIColor whiteColor]];
}

- (void)createModel {
    NSMutableArray *_sectionsArray = [NSMutableArray array];
    NSMutableArray *_itemsArray = [NSMutableArray array];
    NSArray *_featuresArray = [[NSArray alloc] initWithContentsOfFile:
                                [[NSBundle mainBundle] pathForResource:@"features" ofType:@"plist"]];
    
    for (NSArray *_array in _featuresArray) {
        NSMutableArray *_subItems = [NSMutableArray array];
        for (int i=0; i < [_array count]; i++) {
            if (i ==0) {
                [_sectionsArray addObject:[_array objectAtIndex:i]];
            } else {
                TTTableSubtextItem *longTextItem = [TTTableSubtextItem itemWithText:@"" caption:[_array objectAtIndex:i]];
                [_subItems addObject:longTextItem];
            }
        }
        [_itemsArray addObject:_subItems];
        
    }
    
    TT_RELEASE_SAFELY(_featuresArray);
    
    self.dataSource = [TTSectionedDataSource dataSourceWithItems:_itemsArray
                                                        sections:_sectionsArray];
}

@end
