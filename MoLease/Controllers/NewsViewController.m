//
//  NewsViewController.m
//  MoLease
//
//  Created by Chris Voss on 2/19/11.
//  Copyright 2011 Chris Voss. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsDataSource.h"
#import "MoTableViewController.h"


@implementation NewsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    _hasBackgroundView = YES;
    
	if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
		self.title = NSLocalizedString(@"NEWS TITLE", @"news title");
        
        self.variableHeightRows = YES;	
	}
	return self;
}

- (void)createModel {
    TTDINFO(@"Setting News DataSource");
    NSDateFormatter *_df = [[NSDateFormatter alloc] init];
    [_df setDateFormat:@"M-d-yy"];
    
    self.dataSource = [[[NewsDataSource alloc] init] autorelease];
    TT_RELEASE_SAFELY(_df);
}
@end

/**
 * customized table cell for news items
 */
@implementation TTTableMessageItemCell (StyleOverride)

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)identifier {
    if (self == [super initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identifier]) {
        self.textLabel.font = TTSTYLEVAR(font);
        self.textLabel.textColor = TTSTYLE(newsCaptionTextColor);
        self.textLabel.highlightedTextColor = TTSTYLEVAR(highlightedTextColor);
        self.textLabel.textAlignment = UITextAlignmentLeft;
        self.textLabel.lineBreakMode = UILineBreakModeTailTruncation;
        self.textLabel.adjustsFontSizeToFitWidth = YES;
        self.textLabel.contentMode = UIViewContentModeLeft;
        
        self.detailTextLabel.font = TTSTYLEVAR(newsTextFont);
        self.detailTextLabel.textColor = TTSTYLE(newsTextColor);
        self.detailTextLabel.highlightedTextColor = TTSTYLEVAR(highlightedTextColor);
        self.detailTextLabel.textAlignment = UITextAlignmentLeft;
        self.detailTextLabel.contentMode = UIViewContentModeTop;
        self.detailTextLabel.lineBreakMode = UILineBreakModeTailTruncation;
        self.detailTextLabel.numberOfLines = kTableMessageTextLineCount;
        self.detailTextLabel.contentMode = UIViewContentModeLeft;
        
        self.titleLabel.textColor = TTSTYLE(newsTitleTextColor);
    }
    
    return self;
}

@end
