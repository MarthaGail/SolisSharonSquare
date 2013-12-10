//
//  PhotoSource.m
//  MoLease
//
//  Created by Chris Voss on 2/19/11.
//  Copyright 2011 Chris Voss. All rights reserved.
//

#import "PhotoSource.h"


@implementation PhotoSource

@synthesize title = _title;

- (id)initWithTitle:(NSString*)title photos:(NSArray*)photos
           photos2:(NSArray*)photos2 {
    if (self == [super init]) {
        _type = MockPhotoSourceNormal;
        _title = [title copy];
        _photos = photos2 ? [photos mutableCopy] : [[NSMutableArray alloc] init];
        _tempPhotos = photos2 ? [photos2 retain] : [photos retain];
        
        for (int i = 0; i < _photos.count; ++i) {
            id<TTPhoto> photo = [_photos objectAtIndex:i];
            if ((NSNull*)photo != [NSNull null]) {
                photo.photoSource = self;
                photo.index = i;
            }
        }
        
        NSMutableArray* newPhotos = [NSMutableArray array];
        
        for (int i = 0; i < _photos.count; ++i) {
            id<TTPhoto> photo = [_photos objectAtIndex:i];
            if ((NSNull*)photo != [NSNull null]) {
                [newPhotos addObject:photo];
            }
        }
        
        [newPhotos addObjectsFromArray:_tempPhotos];
        TT_RELEASE_SAFELY(_tempPhotos);
        
        [_photos release];
        _photos = [newPhotos retain];
        
        for (int i = 0; i < _photos.count; ++i) {
            id<TTPhoto> photo = [_photos objectAtIndex:i];
            if ((NSNull*)photo != [NSNull null]) {
                photo.photoSource = self;
                photo.index = i;
            }
        }
        
        [_delegates perform:@selector(modelDidFinishLoad:) withObject:self];
    }
    return self;
}

- (BOOL)isLoaded {
    return !!_photos;
}

- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more {
    if (cachePolicy & TTURLRequestCachePolicyNetwork) {
        [_delegates perform:@selector(modelDidStartLoad:) withObject:self];
        
        TT_RELEASE_SAFELY(_photos);
    }
}

- (NSInteger)numberOfPhotos {
    if (_tempPhotos) {
        return _photos.count + (_type & MockPhotoSourceVariableCount ? 0 : _tempPhotos.count);
    } else {
        return _photos.count;
    }
}

- (NSInteger)maxPhotoIndex {
    return _photos.count-1;
}

- (id<TTPhoto>)photoAtIndex:(NSInteger)photoIndex {
    if (photoIndex < _photos.count) {
        id photo = [_photos objectAtIndex:photoIndex];
        if (photo == [NSNull null]) {
            return nil;
        } else {
            return photo;
        }
    } else {
        return nil;
    }
}



@end
