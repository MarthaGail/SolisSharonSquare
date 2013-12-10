//
//  SiteplanViewController.m
//  MoLease
//
//  Created by Chris Voss on 4/9/11.
//  Copyright 2011 Chris Voss. All rights reserved.
//

#import "SiteplanViewController.h"


@implementation SiteplanViewController

- (id) initWithPath:(NSString *)path {
    self = [super init];
    if (self != nil) {        
        self.navigationItem.title = @"Siteplan";
        // TODO: If this is getting loaded twice, remove the init
        // Custom initialization
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _scrollView.maximumZoomScale = 1.5;
        _scrollView.minimumZoomScale = 0.8;
        _scrollView.delegate = self;
        _scrollView.autoresizingMask = ( UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
        
        TTDINFO(@"Path is %@", path);
        NSString *_extension = @".png";
        float _height = 640;
        float _width = 512;
        if ([path isEqualToString:@"places"]) _height = 297;
        if ([path isEqualToString:@"places"]) _width = 610;
        if ([path isEqualToString:@"web"]) _height = 4552;
        if ([path isEqualToString:@"web"]) _width = 768;
        //if ([path isEqualToString:@"places"]) [[UIDevice currentDevice] setDe

        //        [[UIDevice currentDevice] setOrientation:UIInterfaceOrientationLandscapeLeft];

        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            _extension = @"@iPad.png";
            _height = 1024;
            _width = 768;
            if ([path isEqualToString:@"places"]) _height = 748;
            if ([path isEqualToString:@"places"]) _width = 1536;
            //if ([path isEqualToString:@"web"]) _height = 1024;
            //if ([path isEqualToString:@"web"]) _width = 768;
            if ([path isEqualToString:@"web"]) _extension = @".jpg";
            if ([path isEqualToString:@"web"]) path = @"website";


            _scrollView.maximumZoomScale = 4.0;
            _scrollView.minimumZoomScale = 1.0;
            _scrollView.zoomScale = 1.0;


        } 
        _scrollView.contentSize = CGSizeMake(_width, _height);
        TTDINFO(@"setting path to %@", [NSString stringWithFormat:@"bundle://%@%@", path, _extension]);
        _imageView = [[TTImageView alloc] initWithFrame:CGRectMake(0, 0, _width, _height)];
        _imageView.urlPath = [NSString stringWithFormat:@"bundle://%@%@", path, _extension];
        _imageView.center = CGPointMake(_width/2, _height/2);
        _imageView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        //if ([path isEqualToString:@"web"]) _imageView.contentMode = UIViewContentModeScaleAspectFit;

        [_scrollView addSubview:_imageView];
        //        _scrollView.zoomScale = 0.8;
        
        [self.view addSubview:_scrollView];
                
        TTImageView *_backgroundView = [[TTImageView alloc] initWithFrame:self.view.frame];
        [_backgroundView setUrlPath:[NSString stringWithFormat:@"bundle://background%@", _extension]];
        _backgroundView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
        [self.view addSubview:_backgroundView];
        [self.view sendSubviewToBack:_backgroundView];
        
    }
    return self;
}

/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _scrollView.maximumZoomScale = 2.0;
        _scrollView.minimumZoomScale = 0.8;
        _scrollView.delegate = self;
        _scrollView.autoresizingMask = ( UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
        
        NSString *_extension = @".png";
        float _height = 640;
        float _width = 512;
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            _extension = @"@iPad.png";
            _height = 2048;
            _width = 768*2;
        } 
        _scrollView.contentSize = CGSizeMake(_width, _height);
        _imageView = [[TTImageView alloc] initWithFrame:CGRectMake(0, 0, _width, _height)];
        _imageView.urlPath = [NSString stringWithFormat:@"bundle://siteplan%@", _extension];
        [_scrollView addSubview:_imageView];
        _scrollView.zoomScale = 0.8;

        [self.view addSubview:_scrollView];
    }
    return self;
}
 */

- (void)dealloc
{
    TT_RELEASE_SAFELY(_scrollView);
    TT_RELEASE_SAFELY(_imageView);
    TT_RELEASE_SAFELY(_backgroundView);
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma - ScrollView

-(UIView *) viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _imageView;
}


- (void)scrollViewDidZoom:(UIScrollView *)aScrollView {
    CGFloat offsetX = (_scrollView.bounds.size.width > _scrollView.contentSize.width)? 
    (_scrollView.bounds.size.width - _scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (_scrollView.bounds.size.height > _scrollView.contentSize.height)? 
    (_scrollView.bounds.size.height - _scrollView.contentSize.height) * 0.5 : 0.0;
    _imageView.center = CGPointMake(_scrollView.contentSize.width * 0.5 + offsetX, 
                                   _scrollView.contentSize.height * 0.5 + offsetY);
}

#pragma mark - View lifecycle


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    [super loadView];
    
    self.title = @"Siteplan";
}


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;//(interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}

@end
