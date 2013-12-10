//
//  PlacesViewController.h
//  MoLease
//
//  Created by Chris Voss on 2/19/11.
//  Copyright 2011 Chris Voss. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@class Annotation;

/**
 * map of nearby locations
 */
@interface PlacesViewController : TTViewController <MKMapViewDelegate, MKAnnotation, TTTabDelegate, TTURLRequestDelegate> {
    TTTabStrip *_tabStrip;
    MKMapView *_mapView;
 //   NSArray *_placesArray;
    NSDictionary *_categoriesDictionary;
}

- (void)getPlacesOfType:(NSString *)placeType;

@end

/**
 * pin on map screen
 */
@interface Annotation : NSObject <MKAnnotation> {
@private
    NSString *_title;
    NSString *_subtitle;
    UIImage *_image;
    TTImageView *_pinView;
    NSString *_url;
}
@property (nonatomic) CLLocationCoordinate2D theCoordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) UIImage *image;
@property (nonatomic, retain) TTImageView *pinView;
@property (nonatomic, retain) NSString *url;

@end