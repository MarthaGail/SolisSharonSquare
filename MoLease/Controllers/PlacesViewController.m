//
//  PlacesViewController.m
//  MoLease
//
//  Created by Chris Voss on 2/19/11.
//  Copyright 2011 Chris Voss. All rights reserved.
//

#import "PlacesViewController.h"
#import <extThree20JSON/extThree20JSON.h>

@implementation PlacesViewController

- (void)dealloc {
    TT_RELEASE_SAFELY(_tabStrip);
    TT_RELEASE_SAFELY(_mapView);
    _mapView.delegate = nil;
   // TT_RELEASE_SAFELY(_placesArray);
    TT_RELEASE_SAFELY(_categoriesDictionary);
    [super dealloc];
}

//fixes header image going under status bar under in iOS7
- (void) viewDidLayoutSubviews {
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
        
    } else {
        self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
        if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
            self.edgesForExtendedLayout = UIRectEdgeNone;   // iOS 7 specific
        CGRect viewBounds = self.view.bounds;
        CGFloat topBarOffset = self.topLayoutGuide.length;
        viewBounds.origin.y = topBarOffset * -1;
        self.view.bounds = viewBounds;
        self.navigationController.navigationBar.translucent = YES;
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        TTDINFO(@"PlacesViewController init", nil);
        UIScreen *_screen = [UIScreen mainScreen];
        float _deviceWidth = _screen.bounds.size.width;
        
        self.title = NSLocalizedString(@"PLACES TITLE", @"places title");
        
         TTDINFO(@"Creating the tab items", nil);
         _tabStrip = [[TTTabStrip alloc] initWithFrame: CGRectMake(0, 0, _deviceWidth, 40)];
        
        _categoriesDictionary = [[[NSArray alloc] initWithContentsOfFile:
                                 [[NSBundle mainBundle] pathForResource:@"places" 
                                                                 ofType:@"plist"]] objectAtIndex:0];
        TTDASSERT(_categoriesDictionary != nil);

        NSMutableArray *tabArray = [NSMutableArray array];
        for (NSString *keyString in [_categoriesDictionary allKeys]) {
            [tabArray addObject:[[[TTTabItem alloc] initWithTitle:keyString] autorelease]];
        }
        _tabStrip.tabItems = tabArray;
        _tabStrip.selectedTabItem = nil;
        _tabStrip.delegate = self;
        _tabStrip.autoresizingMask = (UIViewAutoresizingFlexibleWidth);
        [self.view addSubview:_tabStrip];
        
        _mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 40, _deviceWidth, _screen.bounds.size.height - 40)];
        _mapView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
		[_mapView setMapType:MKMapTypeStandard];
		
		/*Region and Zoom*/
		MKCoordinateRegion region;
		MKCoordinateSpan span;
		span.latitudeDelta=0.02;
		span.longitudeDelta=0.02;
		
		CLLocationCoordinate2D location=_mapView.userLocation.coordinate;
        
        
        NSString *latString = NSLocalizedString(@"LATITUDE", @"latitude");
        NSString *longString = NSLocalizedString(@"LONGITUDE", @"longitude");

		
		location.latitude = [latString floatValue];
		location.longitude= [longString floatValue];
		region.span=span;
		region.center=location;
		
        Annotation *homeAnnotation = [[[Annotation alloc] init] autorelease];
        CLLocationCoordinate2D coord;
                
        coord.latitude = [latString floatValue];
        coord.longitude = [longString floatValue];
        homeAnnotation.theCoordinate = coord;
        homeAnnotation.title = NSLocalizedString(@"HOME TITLE", @"home location title");
        
        [_mapView addAnnotation:homeAnnotation];
		
		[_mapView setRegion:region animated:TRUE];
		[_mapView regionThatFits:region];
        [_mapView setDelegate:self];
        [self.view addSubview:_mapView];
    }
    return self;
}

- (void)tabBar:(TTTabBar *)tabBar tabSelected:(NSInteger)selectedIndex {
    
    [_mapView removeAnnotations:_mapView.annotations];
    [self getPlacesOfType:[[_categoriesDictionary allValues] objectAtIndex:selectedIndex]];
}

#pragma mark - Personalized annotation

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(Annotation *) annotation{
	
	MKPinAnnotationView *annView=[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"currentloc"];
	NSString *homeTitle = NSLocalizedString(@"HOME TITLE", @"home location title");
	if ([[annotation title] isEqualToString:homeTitle]) {
		NSString *imageString = @"pin.png";
		MKAnnotationView *pinView=[[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"currentloc"];
		UIImage *flagImage = [UIImage imageNamed:imageString];
		
		CGRect resizeRect;
		
		resizeRect.size = flagImage.size;
		CGSize maxSize = CGRectInset(self.view.bounds,
									 1.0f,
									 1.0f).size;
		maxSize.height = 120.0f;//-= self.navigationController.navigationBar.frame.size.height + 4.0f;
		maxSize.width = 120.0f;
		if (resizeRect.size.width > maxSize.width)
			resizeRect.size = CGSizeMake(maxSize.width, resizeRect.size.height / resizeRect.size.width * maxSize.width);
		if (resizeRect.size.height > maxSize.height)
			resizeRect.size = CGSizeMake(resizeRect.size.width / resizeRect.size.height * maxSize.height, maxSize.height);
		
		
		resizeRect.origin = (CGPoint){0.0f, 0.0f};
		UIGraphicsBeginImageContext(resizeRect.size);
		[flagImage drawInRect:resizeRect];
		UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
		UIGraphicsEndImageContext();
		pinView.image = resizedImage;
		pinView.opaque = NO;
		pinView.canShowCallout = YES;
		pinView.calloutOffset = CGPointMake(-5, 5);
		[annView release];
		return [pinView autorelease];
		
	}
	
    
	
	annView.frame = CGRectMake(0, 0, 32, 32);
	annView.canShowCallout = YES;
	annView.calloutOffset = CGPointMake(-5, 5);
	return [annView autorelease];
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) return YES;
    return NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

/**
 * request a list of places from google
 */
- (void)getPlacesOfType:(NSString *)placeType {
    NSString *latString = NSLocalizedString(@"LATITUDE", @"latitude");
    NSString *longString = NSLocalizedString(@"LONGITUDE", @"longitude");

    NSString *url = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=%@,%@&radius=1200&types=%@&sensor=false&key=AIzaSyBbtXsnAGKadxGVLfrX0YxgEFjM7WXimtI",
                     latString, longString, placeType];
    TTDINFO(@"Requesting url: %@", url);
    TTURLRequest* request = [TTURLRequest requestWithURL:url delegate: self];    
    TTURLJSONResponse* response = [[TTURLJSONResponse alloc] init];
    request.cacheExpirationAge = 0;
    request.response = response;
    TT_RELEASE_SAFELY(response);

    [request send];
}

#pragma mark - TTURLRequest

- (void)requestDidFinishLoad:(TTURLRequest *)request {
    TTDINFO(@"RequestDidFinishLoad", nil);    
    TTURLJSONResponse* response = request.response;
    TTDASSERT([response.rootObject isKindOfClass:[NSDictionary class]]);
    
    TTDINFO(@"response is %@", [response.rootObject description]);
    
    for (NSDictionary *place in [response.rootObject objectForKey:@"results"]) {
        Annotation *placeAnnotation = [[[Annotation alloc] init] autorelease];
        
        CLLocationCoordinate2D coord;
        coord.latitude = [[[[place objectForKey:@"geometry"] objectForKey:@"location"] objectForKey:@"lat"] floatValue];
        coord.longitude = [[[[place objectForKey:@"geometry"] objectForKey:@"location"] objectForKey:@"lng"] floatValue];
        NSLog(@"coord is %f and %f", coord.latitude, coord.longitude);
        placeAnnotation.theCoordinate = coord;
        placeAnnotation.title = [place objectForKey:@"name"];
        placeAnnotation.subtitle = [place objectForKey:@"vicinity"];
//        UIImage *tempImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[place objectForKey:@"icon"]]]];
//        NSLog(@"image is %@", [place objectForKey:@"icon"]);
        
        TTImageView *backgroundView = [[[TTImageView alloc] initWithFrame:CGRectMake(0, 0, 48, 48)] autorelease];
        backgroundView.opaque = NO;
        backgroundView.urlPath = [place objectForKey:@"icon"];
        backgroundView.style = [TTShapeStyle styleWithShape:[TTRoundedRectangleShape shapeWithRadius:24] next:
                                [TTSolidBorderStyle styleWithColor:[UIColor blackColor] width:2 next:
                                 [TTSolidFillStyle styleWithColor:[UIColor whiteColor] next:
                                  [TTImageStyle styleWithImage:nil defaultImage:nil contentMode:UIViewContentModeScaleAspectFit size:CGSizeMake(32,32) next:nil]]]];
        
        placeAnnotation.pinView = backgroundView;
        // placeAnnotation.url = [place objectForKey:@"url"];

        [_mapView addAnnotation:placeAnnotation];
        
    }
    
    Annotation *homeAnnotation = [[[Annotation alloc] init] autorelease];
    CLLocationCoordinate2D coord;

    NSString *latString = NSLocalizedString(@"LATITUDE", @"latitude");
    NSString *longString = NSLocalizedString(@"LONGITUDE", @"longitude");

    coord.latitude = [latString floatValue];
    coord.longitude = [longString floatValue];
    homeAnnotation.theCoordinate = coord;
    homeAnnotation.title = NSLocalizedString(@"HOME TITLE", @"home location title");
    
    [_mapView addAnnotation:homeAnnotation];

    
}

@end

@implementation Annotation

@synthesize theCoordinate, title = _title, subtitle = _subtitle, image = _image, pinView = _pinView, url = _url;

- (CLLocationCoordinate2D)coordinate;
{
	
    CLLocationCoordinate2D aCoordinate;
	aCoordinate.latitude=self.theCoordinate.latitude;
	aCoordinate.longitude=self.theCoordinate.longitude;
    return aCoordinate; 
}

@end