//
//  News.h
//  MoLease
//
//  Created by Chris Voss on 2/19/11.
//  Copyright 2011 Chris Voss. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * news item model
 */
@interface NewsModel : TTURLRequestModel {
    NSMutableArray *_news;
}

/**
 * items array
 */
@property (nonatomic, copy) NSMutableArray *news;

@end
