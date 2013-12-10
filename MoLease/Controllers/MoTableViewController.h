//
//  MoTableViewController.h
//  MoLease
//
//  Created by Chris Voss on 6/26/11.
//  Copyright 2011 Chris Voss. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MoTableViewController : TTTableViewController {
    /**
     * the header view
     */
    TTImageView *_headerView;
    
    /**
     * should this view have a header
     */
    bool _hasHeaderView;
    
    /**
     * background view
     */
    TTImageView *_backgroundView;
    
    /**
     * should this view have a background
     */
    bool _hasBackgroundView;
    
    /**
     * header image
     */
    NSString *_headerURL;

}

@end
