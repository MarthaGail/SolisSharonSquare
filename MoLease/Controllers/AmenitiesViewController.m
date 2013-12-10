//
//  AmenitiesViewController.m
//  MoLease
//
//  Created by Chris Voss on 4/12/11.
//  Copyright 2011 Chris Voss. All rights reserved.
//
#import "AmenitiesViewController.h"

@implementation AmenitiesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    _hasHeaderView = YES;
    _headerURL = @"bundle://header_amenities%@";
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
        self.title = NSLocalizedString(@"AMENITIES TITLE", @"amenities title");
        self.variableHeightRows = YES;
    }
    return self;
}

- (void)createModel {
    NSMutableArray *_sectionsArray = [NSMutableArray array];
    NSMutableArray *_itemsArray = [NSMutableArray array];
    NSArray *_amenitiesArray = [[NSArray alloc] initWithContentsOfFile:
                                [[NSBundle mainBundle] pathForResource:@"amenities" ofType:@"plist"]];
    
    for (NSArray *_array in _amenitiesArray) {
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
    
    TT_RELEASE_SAFELY(_amenitiesArray);
    
    self.dataSource = [TTSectionedDataSource dataSourceWithItems:_itemsArray
                                                        sections:_sectionsArray];
}

@end
