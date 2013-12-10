//
//  FloorplanDetailViewController.h
//  MoLease
//
//  Created by Chris Voss on 2/19/11.
//  Copyright 2011 Chris Voss. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>
#import "MoTableViewController.h"
@class MoDataSource;
/**
 * floorplan detail view controller
 */
@interface FloorplanDetailViewController : MoTableViewController 
<MFMailComposeViewControllerDelegate,MFMessageComposeViewControllerDelegate> {
    /**
     * the floorplan contents
     */
    NSDictionary *_floorplan;
        
    /**
     * floorplan header view
     */
    TTImageView *_fpHeaderView;
}

- (void)sendEmail;
- (void)sendText;

@end
