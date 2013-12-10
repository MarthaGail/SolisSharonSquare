//
//  FloorplansViewController.m
//  MoLease
//
//  Created by Chris Voss on 2/19/11.
//  Copyright 2011 Chris Voss. All rights reserved.
//

#import "FloorplansViewController.h"

@implementation FloorplansViewController

- (void)dealloc {
    TT_RELEASE_SAFELY(_headerView);
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    _hasHeaderView = YES;
    _headerURL = @"bundle://header_floorplans%@";

    if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        TTDINFO(@"Initializing Floorplans", nil);
        self.title = NSLocalizedString(@"FLOORPLANS TITLE", @"floorplans title");
    }
    return self;
}

- (void)didSelectObject:(id)object atIndexPath:(NSIndexPath*)indexPath {	
    // have to do it this way vs a url to pass the floorplan data
	TTURLAction *urlAction = [TTURLAction actionWithURLPath:@"mo://floorplan?"];
    TTDINFO(@"touched %@", [object description]);
	[urlAction setQuery:[object userInfo]];	
	[urlAction applyAnimated:YES];
    TTDINFO(@"opening url action: %@", urlAction.urlPath);
	[[TTNavigator navigator] openURLAction:urlAction];
}

#pragma -
#pragma TTModelViewController

- (void)createModel
{
    // load the floorplans.plist file for content
    NSArray *_floorplansArray = [[[NSArray alloc] initWithContentsOfFile:
                                 [[NSBundle mainBundle] pathForResource:@"floorplans" ofType:@"plist"]] autorelease];
    TTDINFO(@"Loaded floorplans: %@", [_floorplansArray description]);
    
    NSMutableArray *_sectionsArray = [NSMutableArray array];
    NSMutableArray *_itemsArray = [NSMutableArray array];
    for (NSDictionary *_sectionDictionary in _floorplansArray) {
        
        TTDINFO(@"Adding %@ to sections array", [_sectionDictionary objectForKey:@"section_name"]);
        [_sectionsArray addObject:[_sectionDictionary objectForKey:@"section_name"]];
        
        NSMutableArray *_groupArray = [NSMutableArray array];
        
        for (NSDictionary *_floorplanDictionary in [_sectionDictionary objectForKey:@"floorplans"]) {
            TTDINFO(@"Adding floorplan: %@", [_floorplanDictionary description]);
            // Floorplan thumbnails
            // NOTE: all floorplan thumbnails must end with _thumb.png and title comes from "short" property
            NSString *_thumbnailPath = [NSString stringWithFormat:@"bundle://%@_thumb.png",
                                        [_floorplanDictionary objectForKey:@"short"]];
            TTDINFO(@"floorplan has a thumbnail: %@", _thumbnailPath);
            
            TTTableImageItem *_tempTableItem = [TTTableSubtitleItem itemWithText:[_floorplanDictionary objectForKey:@"name"]
                                                                        subtitle:[_floorplanDictionary objectForKey:@"short_description"] 
                                                                        imageURL:_thumbnailPath 
                                                                             URL:nil];
            [_tempTableItem setUserInfo:_floorplanDictionary];
            [_groupArray addObject:_tempTableItem];
        }
        [_itemsArray addObject:_groupArray];
    }
     
    TTDINFO(@"Setting datasource", nil);
    self.dataSource = [TTSectionedDataSource dataSourceWithItems:_itemsArray 
                                                        sections:_sectionsArray];                    
}


@end
