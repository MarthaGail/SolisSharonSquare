//
//  SiteplanViewController.h
//  MoLease
//
//  Created by Chris Voss on 4/9/11.
//  Copyright 2011 Chris Voss. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SiteplanViewController : TTViewController <UIScrollViewDelegate> {
    UIScrollView *_scrollView;
    TTImageView *_imageView;
    TTImageView *_backgroundView;
}

@end
