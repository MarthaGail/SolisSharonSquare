//
//  Photo.h
//  MoLease
//
//  Created by Chris Voss on 2/19/11.
//  Copyright 2011 Chris Voss. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * photo gallery photo object
 */
@interface Photo : NSObject <TTPhoto> {
    id<TTPhotoSource> _photoSource;
    NSString* _thumbURL;
    NSString* _smallURL;
    NSString* _URL;
    CGSize _size;
    NSInteger _index;
    NSString* _caption;
    NSString* _mediaFormat;
}

- (id)initWithURL:(NSString*)URL smallURL:(NSString*)smallURL size:(CGSize)size
          caption:(NSString*)caption;
- (id)initWithURL:(NSString*)URL smallURL:(NSString*)smallURL size:(CGSize)size;

@end
