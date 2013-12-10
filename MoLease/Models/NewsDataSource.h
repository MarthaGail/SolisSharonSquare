//
//  NewsDataSource.h
//  MoLease
//
//  Created by Chris Voss on 2/19/11.
//  Copyright 2011 Chris Voss. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NewsModel;

/**
 * gets blog entries from remote source
 */
@interface NewsDataSource : TTListDataSource {
    /**
     * news model
     */
    NewsModel *_newsModel;
}

@end
