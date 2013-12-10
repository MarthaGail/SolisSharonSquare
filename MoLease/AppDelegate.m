//
//  MoLeaseAppDelegate.m
//  MoLease
//
//  Created by Chris Voss on 2/17/11.
//  Copyright 2011 Chris Voss. All rights reserved.
//

#import "AppDelegate.h"
#import "HTNotifier_iOS.h"
#import "HomeViewController.h"
#import "Stylesheet.h"
#import "PlacesViewController.h"
#import "FloorplansViewController.h"
#import "FloorplanDetailViewController.h"
#import "PhotoViewController.h"
#import "LinksViewController.h"
#import "ApplyViewController.h"
#import "NewsViewController.h"
#import "AmenitiesViewController.h"
#import "FeaturesViewController.h"
#import "SiteplanViewController.h"

@implementation AppDelegate

@synthesize window=_window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    // Set this variable to YES and it will print out all of the font names in the Xcode console (bottom right pane). This is how you can match up the correct name if the font isn't loading for you
    BOOL showFontNamesInConsoleOnStartup = NO;
    if (showFontNamesInConsoleOnStartup) {
        for (NSString *fontFamilyName in [UIFont familyNames]) {
            NSLog([[UIFont fontNamesForFamilyName:fontFamilyName] description], nil);
        }
    }
    
    
    
    // Hoptoad integration
    TTDINFO(@"Starting Hoptoad...");
    [HTNotifier startNotifierWithAPIKey:@"5f9d687b401f5ce1e38463f0872beb35"
                        environmentName:HTNotifierDevelopmentEnvironment];
    //TTDINFO(@"Writing test notice");
    //[[HTNotifier sharedNotifier] writeTestNotice];
    
    [[TTURLRequestQueue mainQueue] setMaxContentLength:0];
    
    // Set global stylesheet
    TTDINFO(@"Setting the stylesheet", nil);
	[TTStyleSheet setGlobalStyleSheet:[[[Stylesheet alloc]
                                        init] autorelease]];
    
    // Navigator
    TTDINFO(@"Setting the navigator", nil);
    TTNavigator* navigator = [TTNavigator navigator];
    navigator.window = _window;
    
    // Map urls
    TTDINFO(@"Mapping urls to the navigator", nil);
    TTURLMap* map = navigator.URLMap;
    [map from:@"*" toViewController:[TTWebController class]];
    [map from:@"mo://home" toSharedViewController:[HomeViewController class]];
    [map from:@"mo://places" toViewController:[PlacesViewController class]];
    [map from:@"mo://floorplans" toSharedViewController:[FloorplansViewController class]];
    [map from:@"mo://floorplan?" toViewController:[FloorplanDetailViewController class]];
    [map from:@"mo://news" toViewController:[NewsViewController class]];
    [map from:@"mo://photos" toViewController:[PhotoViewController class]];
    [map from:@"mo://links" toViewController:[LinksViewController class]];
    [map from:@"mo://links/(initWithPath:)" toViewController:[LinksViewController class]];
    [map from:@"mo://apply" toViewController:[ApplyViewController class]];
    [map from:@"mo://siteplan/(initWithPath:)" toViewController:[SiteplanViewController class]];
    [map from:@"mo://amenities" toSharedViewController:[AmenitiesViewController class]];
    [map from:@"mo://features" toSharedViewController:[FeaturesViewController class]];
    [map from:@"mo://videos" toSharedViewController:nil];
    
    TTDINFO(@"Opening the root path", nil);
    [navigator openURLAction:[TTURLAction actionWithURLPath:@"mo://home"]];
    
    application.statusBarStyle = UIStatusBarStyleBlackOpaque;
    
    
    [self.window makeKeyAndVisible];
    
    // fix rotation bug in iOS 6
    [[[UIApplication sharedApplication] keyWindow] setRootViewController:[[TTNavigator navigator] rootViewController]];
    
    return YES;
}

- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) return UIInterfaceOrientationMaskAll;
    return UIInterfaceOrientationMaskPortrait;
}

- (void)crash {
    TTDINFO(@"Crashing", nil);
    [[HTNotifier sharedNotifier] writeTestNotice];
    exit(0);
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

@end