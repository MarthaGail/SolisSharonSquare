//
//  MoTableViewController.m
//  MoLease
//
//  Created by Chris Voss on 6/26/11.
//  Copyright 2011 Chris Voss. All rights reserved.
//

#import "MoTableViewController.h"

@implementation MoTableViewController

- (void)dealloc {
    TT_RELEASE_SAFELY(_headerView);
    TT_RELEASE_SAFELY(_backgroundView);
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        NSString *_extension = @".png";
        float _headerHeight = 110;
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            _extension = @"@iPad.png";
            _headerHeight = 278;
        } 

        if (_hasHeaderView == YES) {
            
            
            
            _headerView = [[TTImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, _headerHeight)];
            _headerView.urlPath = [NSString stringWithFormat:_headerURL, _extension];
            _headerView.backgroundColor = (UIColor *)TTSTYLE(headerBackgroundColor);
            _headerView.contentMode = UIViewContentModeScaleAspectFill;
            _headerView.autoresizingMask = (UIViewAutoresizingFlexibleWidth);
            _headerView.clipsToBounds = YES;
            self.tableView.tableHeaderView = _headerView;
            self.tableView.backgroundColor = (UIColor *)TTSTYLE(floorplansTableBackgroundColor);
        }
        
        if (_hasBackgroundView) {
            _backgroundView = [[TTImageView alloc] initWithFrame:self.view.frame];
            [_backgroundView setUrlPath:[NSString stringWithFormat:@"bundle://background%@", _extension]];
            _backgroundView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
            self.tableView.backgroundView = _backgroundView;
        }
    }
    return self;
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    // [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

@end
