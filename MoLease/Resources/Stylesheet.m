//
//  Stylesheet.m
//  MoLease
//
//  Created by Chris Voss on 2/19/11.
//  Copyright 2011 Chris Voss. All rights reserved.
//

#import "Stylesheet.h"

@implementation Stylesheet

#pragma mark - Fonts

/**
 * main app font
 */
- (UIFont *)font {
    return [UIFont fontWithName:@"Avenir-Heavy" size:15];
}

/**
 * table header font, amenities
 */
- (UIFont *)tableHeaderPlainFont {
    return [UIFont fontWithName:@"Avenir-Black" size:25];
}

/**
 * table font, floor plans
 */
- (UIFont *)tableFont {
    return [UIFont fontWithName:@"Avenir-Heavy" size:17];
}

/**
 * news font
 */
- (UIFont *)newsTextFont {
    return [UIFont fontWithName:@"Avenir-Book" size:13];
}

#pragma mark - Text Colors

- (UIColor *)tableTitleTextColor {
    return RGBACOLOR(106, 115, 123, 1);
}

// Amenities header
- (UIColor *)tableHeaderTextColor {
    return RGBACOLOR(189, 47, 42, 1);
}

- (UIColor *)newsTitleTextColor {
    return RGBACOLOR(255, 255, 255, 1);
}

- (UIColor *)newsCaptionTextColor {
    return RGBACOLOR(255, 255, 255, 1);
}

- (UIColor *)newsTextColor {
    return RGBACOLOR(255, 255, 255, 1);
}

#pragma mark - UI Styles

/**
 * the tint color of the navigation bar at the top of the app
 */
- (UIColor *)navigationBarTintColor {
    return [UIColor blackColor];
}

/**
 * the tint color of the tool bar at the bottom of the app
 */
- (UIColor *)toolbarTintColor {
	return [UIColor blackColor];
}

/**
 * background color of the app, if no image is used
 */
- (UIColor *)backgroundColor {
	return [UIColor lightGrayColor];
}

/**
 * background color of the header
 */
- (UIColor *)headerBackgroundColor {
    return RGBACOLOR(151, 200, 71, 1);
}

#pragma mark - Home screen launcher

- (TTStyle*)launcherButton:(UIControlState)state { 
    float _textSize = 15;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) _textSize = 16;
    
	return 
    [TTPartStyle styleWithName:@"image" style:TTSTYLESTATE 
	 (launcherButtonImage:, state) next: 
	 [TTTextStyle styleWithFont:[UIFont fontWithName:@"Avenir-Heavy" size:_textSize]
						  color:RGBACOLOR(106, 115, 123, 1)
                minimumFontSize:11
                    shadowColor:RGBCOLOR(92,92,92)
				   shadowOffset:CGSizeMake(0, 0) next:nil]];
} 

- (TTStyle*)pageDot:(UIControlState)state {
	if (state == UIControlStateSelected) {
		return [self pageDotWithColor:RGBACOLOR(85, 85, 85, 0)];
	} else {
		return [self pageDotWithColor:RGBACOLOR(151, 200, 71, 0)];
	}
}

#pragma mark - Tables
 
- (UIColor *)floorplansTableBackgroundColor {
    return RGBACOLOR(255, 255, 255, 1);
}

// Amenities
- (UIColor *)tableHeaderTintColor {
    return RGBCOLOR(255, 255, 255);
}

- (TTStyle *)selectionFillStyle:(TTStyle *)next {
    // TODO: unnecessary?
    return [TTSolidFillStyle styleWithColor:RGBACOLOR(151, 200, 71, 1) next:nil];
}

- (UIColor *)tableHeaderShadowColor {
    return RGBACOLOR(255, 255, 255, 0);
}

// link headers, floor plan detail headers
- (TTStyle *)headerCell {
    return [TTTextStyle styleWithFont:[UIFont fontWithName:@"Avenir-Black" size:25]
                                color:RGBACOLOR(189, 47, 42, 1)
                      minimumFontSize:30
                          shadowColor:RGBACOLOR(255, 255, 255, 0)
                         shadowOffset:CGSizeMake(0, 0)
                        textAlignment:UITextAlignmentLeft
                    verticalAlignment:UIControlContentVerticalAlignmentCenter
                        lineBreakMode:UILineBreakModeTailTruncation
                        numberOfLines:1
                                 next:nil];
}


#pragma mark - Buttons

- (TTStyle *)emailButton:(UIControlState)state {
    return [TTShapeStyle styleWithShape:[TTRectangleShape shape] next:
            [TTSolidFillStyle styleWithColor:RGBACOLOR(151, 200, 71, 1) next:
             [TTTextStyle styleWithFont:[UIFont fontWithName:@"Avenir-Heavy" size:17]
                                  color:RGBACOLOR(0, 0, 0, 1)
                        minimumFontSize:14
                            shadowColor:nil
                           shadowOffset:CGSizeMake(0, 0) 
                          textAlignment:UITextAlignmentCenter
                      verticalAlignment:UIControlContentVerticalAlignmentCenter
                          lineBreakMode:UILineBreakModeTailTruncation
                          numberOfLines:1 
                                   next:nil]]];
             }


@end
