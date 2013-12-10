//
//  HomeViewController.m
//  MoLease
//
//  Created by Chris Voss on 2/19/11.
//  Copyright 2011 Chris Voss. All rights reserved.
//

#import "HomeViewController.h"
#import "AppDelegate.h"

@implementation HomeViewController

- (void)didReceiveMemoryWarning {
    // if we don't override this method and a memory warning is triggered, the home screen goes blank
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
    if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.title = NSLocalizedString(@"APP TITLE", @"title of the app");
        self.navigationController.toolbar.tintColor = (UIColor *)TTSTYLE(toolbarTintColor);
        
        _launcherView = [[TTLauncherView alloc] initWithFrame:self.view.frame];
        _launcherView.delegate = self;
        _launcherView.columnCount = 3;
        
        _backgroundView = [[TTImageView alloc] initWithFrame:self.view.frame];
        _backgroundView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            [_backgroundView setUrlPath:@"bundle://home_screen@iPad.png"];
        } else {
            [_backgroundView setUrlPath:@"bundle://home_screen.png"];
        }
        
        _backgroundView.contentMode = UIViewContentModeScaleAspectFill;
        [_launcherView addSubview:_backgroundView];
        [_launcherView sendSubviewToBack:_backgroundView];
        
        /*
         // can't remember why I did this
         // TODO: review
         TTURLCache *_urlCache = [[TTURLCache alloc] init];
         [_urlCache removeAll:YES];
         TT_RELEASE_SAFELY(_urlCache);
         */
        
        // NOTE: all iPad images should end with @iPad.png
        NSString *_extension = @".png";
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            _extension = @"@iPad.png";
        } 
        
        NSString *applicationUrl = NSLocalizedString(@"APPLY URL", @"apply url");
        // if applicationUrl = @"mo://apply" it will load the built-in apply view
        
        NSArray *_pageArray = [NSArray arrayWithObjects:
                               [[[TTLauncherItem alloc] initWithTitle:@"FLOORPLANS"
                                                                image:[NSString stringWithFormat:@"bundle://icon_floorplans%@", _extension]
                                                                  URL:@"mo://floorplans" 
                                                            canDelete:NO] autorelease],
                               [[[TTLauncherItem alloc] initWithTitle:@"SITEPLAN"
                                                                image:[NSString stringWithFormat:@"bundle://icon_siteplan%@", _extension]
                                                                  URL:NSLocalizedString(@"SITEPLAN URL", @"siteplan url")
                                                            canDelete:NO] autorelease],
                               [[[TTLauncherItem alloc] initWithTitle:@"PLACES"
                                                                image:[NSString stringWithFormat:@"bundle://icon_places%@", _extension]
                                                                  URL:@"mo://places" 
                                                            canDelete:NO] autorelease],
                               [[[TTLauncherItem alloc] initWithTitle:@"GALLERY"
                                                                image:[NSString stringWithFormat:@"bundle://icon_gallery%@", _extension]
                                                                  URL:@"mo://photos" 
                                                            canDelete:NO] autorelease],
                               [[[TTLauncherItem alloc] initWithTitle:@""
                                                                image:@""
                                                                  URL:@"mo://apply" 
                                                            canDelete:NO] autorelease],
                               [[[TTLauncherItem alloc] initWithTitle:@"AMENITIES"
                                                                image:[NSString stringWithFormat:@"bundle://icon_amenities%@", _extension]
                                                                  URL:@"mo://amenities" 
                                                            canDelete:NO] autorelease],
                               [[[TTLauncherItem alloc] initWithTitle:@"LINKS"
                                                                image:[NSString stringWithFormat:@"bundle://icon_links%@", _extension]
                                                                  URL:@"mo://links" 
                                                            canDelete:NO] autorelease],
                               [[[TTLauncherItem alloc] initWithTitle:@"SOCIAL"
                                                                image:[NSString stringWithFormat:@"bundle://icon_news%@", _extension]
                                                                  //URL:@"mo://news"
                                                                  URL:@"https://www.facebook.com/AvenueRApartments"
                                                            canDelete:NO] autorelease],
                               [[[TTLauncherItem alloc] initWithTitle:@"APPLY"
                                                                image:[NSString stringWithFormat:@"bundle://icon_video%@", _extension]
                                                                  //URL:NSLocalizedString(@"VIDEOS URL", @"videos url")
                                                                  URL:@""
                                                            canDelete:NO] autorelease],
                               nil];
        
        
        _launcherView.backgroundColor = [UIColor blackColor];
        _launcherView.pages = [NSArray arrayWithObjects:_pageArray,nil];
        self.view = _launcherView;
    }
    return self;
}

- (void)loadView {
	/**
	 Sent when the view is loaded. Set up and style the home screen.
     */
	[super loadView];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) return YES;
    return NO;
}


#pragma mark - Launcher View Delegate

- (void)launcherView:(TTLauncherView*)launcher didSelectItem:(TTLauncherItem*)item {
    
    if ([[item title] isEqualToString:@"APPLY"]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://property.onesite.realpage.com/crossfire/availability/default.aspx?s=2849831"]];
        return;
    }
    
	/*
     Sent when someone taps an item on the home screen.
     */
    
	TTNavigator* navigator = [TTNavigator navigator];
	[navigator openURLAction:[TTURLAction actionWithURLPath:[item URL]]];
}

- (void)launcherViewDidBeginEditing:(TTLauncherView*)launcher {
	/*
     Sent when the user activates "wiggle mode"
     */
	[self.navigationItem setRightBarButtonItem:[[[UIBarButtonItem alloc]
												 initWithBarButtonSystemItem:UIBarButtonSystemItemDone
												 target:_launcherView action:@selector(endEditing)] 
                                                autorelease] animated:YES];
}

- (void)launcherViewDidEndEditing:(TTLauncherView*)launcher {
	/*
     Sent when the user taps the DONE button to end "wiggle mode"
     */
	[self.navigationItem setRightBarButtonItem:nil animated:YES];
}

#pragma mark - Private

/**
 * open the Apply controller
 */
- (void)apply:(id)sender {
    [[TTNavigator navigator] openURLAction:[[TTURLAction actionWithURLPath:@"mo://apply"] 
                                            applyAnimated:YES]];
}

#pragma mark - ActionSheet delegate

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    TTDINFO(@"Clicked button %d", buttonIndex);
    if (buttonIndex == 0) {
        AppDelegate *_appDel = [[UIApplication sharedApplication] delegate];
        [_appDel crash];
    } 
}

@end
