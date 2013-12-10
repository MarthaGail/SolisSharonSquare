//
//  PhotoViewController.m
//  MoLease
//
//  Created by Chris Voss on 2/19/11.
//  Copyright 2011 Chris Voss. All rights reserved.
//

#import "PhotoViewController.h"
#import "PhotoSource.h"
#import "Photo.h"


@implementation PhotoViewController

- (void)viewDidLoad {
    TTDINFO(@"Loading gallery plist", nil);
    NSArray *_galleryArray = [[NSArray alloc] initWithContentsOfFile:
                              [[NSBundle mainBundle] pathForResource:@"gallery" ofType:@"plist"]];
    TTDASSERT(nil != _galleryArray);
    
    NSMutableArray *_photosArray = [NSMutableArray array];
    
    for (NSString *_fileName in _galleryArray) {
        TTDINFO(@"Adding photo to array: %@", _fileName);
        
        [_photosArray addObject:[[[Photo alloc]
                                  initWithURL:_fileName
                                  smallURL:_fileName
                                  size:CGSizeZero
                                  caption:nil] autorelease]];
    }
    
    NSString *photosTitle = NSLocalizedString(@"PHOTOS TITLE", @"photo gallery title");
    self.photoSource = [[[PhotoSource alloc] initWithTitle:photosTitle 
                                                    photos:_photosArray
                                                   photos2:nil] autorelease];
    TT_RELEASE_SAFELY(_galleryArray);
}




@end
