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
    return [UIFont fontWithName:@"Eurostile" size:14];
}

/**
 * table header font
 */
- (UIFont *)tableHeaderPlainFont {
    return [self font];
}

/**
 * table font
 */
- (UIFont *)tableFont {
    return [UIFont fontWithName:@"Eurostile" size:17];
}

/**
 * news font
 */
- (UIFont *)newsTextFont {
    return [UIFont fontWithName:@"Eurostile" size:13];
}

#pragma mark - Text Colors

- (UIColor *)tableTitleTextColor {
    return RGBACOLOR(103, 103, 103, 1);
}

- (UIColor *)tableHeaderTextColor {
    return RGBACOLOR(223, 223, 223, 1);
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
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) _textSize = 17;
    
	return 
    [TTPartStyle styleWithName:@"image" style:TTSTYLESTATE 
	 (launcherButtonImage:, state) next: 
	 [TTTextStyle styleWithFont:[UIFont fontWithName:@"GillSans" size:_textSize] 
						  color:[UIColor blackColor]
				minimumFontSize:11 shadowColor:RGBCOLOR(92,92,92)
				   shadowOffset:CGSizeMake(0, 0) next:nil]];
} 

- (TTStyle*)pageDot:(UIControlState)state {
	if (state == UIControlStateSelected) {
		return [self pageDotWithColor:RGBACOLOR(85, 85, 85, 1)];
	} else {
		return [self pageDotWithColor:RGBACOLOR(151, 200, 71, 1)];
	}
}

#pragma mark - Tables
 
- (UIColor *)floorplansTableBackgroundColor {
    return RGBACOLOR(243, 243, 243, 1);
}

- (UIColor *)tableHeaderTintColor {
    return RGBCOLOR(93,92,92);
}

- (TTStyle *)selectionFillStyle:(TTStyle *)next {
    // TODO: unnecessary?
    return [TTSolidFillStyle styleWithColor:RGBACOLOR(151, 200, 71, 1) next:nil];
}

- (UIColor *)tableHeaderShadowColor {
    return RGBACOLOR(103, 103, 103, 1);
}

- (TTStyle *)headerCell {
    return [TTTextStyle styleWithFont:[UIFont fontWithName:@"Eurostile" size:25]
                      color:RGBACOLOR(241, 123, 47, 1)
                      minimumFontSize:30
                      shadowColor:RGBACOLOR(85, 85, 85, 1)
                      shadowOffset:CGSizeMake(0, 1)
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
             [TTTextStyle styleWithFont:[UIFont fontWithName:@"Eurostile" size:17]
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
