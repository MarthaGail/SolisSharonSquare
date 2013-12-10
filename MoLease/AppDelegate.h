//
//  MoLeaseAppDelegate.h
//  MoLease
//
//  Created by Chris Voss on 2/17/11.
//  Copyright 2011 Chris Voss. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HTNotifier_iOS;
@class HomeViewController;
@class Stylesheet;
@class PlacesViewController;
@class FloorplansViewController;
@class FloorplanDetailViewController;
@class NewsViewController;
@class PhotoViewController;
@class LinksViewController;
@class ApplyViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

- (void)crash;

@end
