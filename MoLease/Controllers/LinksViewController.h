//
//  SocialViewController.h
//  MoLease
//
//  Created by Chris Voss on 2/19/11.
//  Copyright 2011 Chris Voss. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MoTableViewController.h"
@class MoDataSource;

/**
 * displays links in a table
 */
@interface LinksViewController : MoTableViewController {
    NSString *_path;
}
- (id)initWithPath:(NSString *)path;

@end
