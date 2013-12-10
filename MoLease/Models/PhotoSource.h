//
//  PhotoSource.h
//  MoLease
//
//  Created by Chris Voss on 2/19/11.
//  Copyright 2011 Chris Voss. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    MockPhotoSourceNormal = 0,
    MockPhotoSourceDelayed = 1,
    MockPhotoSourceVariableCount = 2,
    MockPhotoSourceLoadError = 4,
} MockPhotoSourceType;

/**
 * photo gallery datasource
 */
@interface PhotoSource : TTURLRequestModel <TTPhotoSource> {
    MockPhotoSourceType _type;
    NSMutableArray *_photos;
    NSArray *_tempPhotos;
    NSString *_title;
}

@end
