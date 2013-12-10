//
//  Photo.m
//  MoLease
//
//  Created by Chris Voss on 2/19/11.
//  Copyright 2011 Chris Voss. All rights reserved.
//

#import "Photo.h"


@implementation Photo

@synthesize photoSource = _photoSource, size = _size, index = _index, caption = _caption;

- (id)initWithURL:(NSString*)URL smallURL:(NSString*)smallURL size:(CGSize)size {
    return [self initWithURL:URL smallURL:smallURL size:size caption:nil];
}

- (id)initWithURL:(NSString*)URL smallURL:(NSString*)smallURL size:(CGSize)size
          caption:(NSString*)caption {
    if (self = [super init]) {
        _photoSource = nil;
        _URL = [URL copy];
        _smallURL = [smallURL copy];
        _thumbURL = [smallURL copy];
        _size = size;
        _caption = [caption copy];
        _index = NSIntegerMax;
    }
    return self;
}

- (NSString*)URLForVersion:(TTPhotoVersion)version {
    if (version == TTPhotoVersionLarge) {
        return _URL;
    } else if (version == TTPhotoVersionMedium) {
        return _URL;
    } else if (version == TTPhotoVersionSmall) {
        return _smallURL;
    } else if (version == TTPhotoVersionThumbnail) {
        return _thumbURL;
    } else {
        return nil;
    }
}



@end
