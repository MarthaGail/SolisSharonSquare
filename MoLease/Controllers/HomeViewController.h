//
//  HomeViewController.h
//  MoLease
//
//  Created by Chris Voss on 2/19/11.
//  Copyright 2011 Chris Voss. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * the home screen displays icons that launch each module in the app
 */
@interface HomeViewController : TTViewController <TTLauncherViewDelegate, UIActionSheetDelegate> {
    /**
     * home screen launcher view
     */
	TTLauncherView* _launcherView;
    
    /**
     * background view
     */
    TTImageView *_backgroundView;
}

@end
