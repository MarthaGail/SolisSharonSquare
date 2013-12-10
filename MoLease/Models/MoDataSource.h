//
//  MoDataSource.h
//  MoLease
//
//  Created by Chris Voss on 4/9/11.
//  Copyright 2011 Chris Voss. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ClearBackgroundTTStyledTextTableItemCell;

/**
 * General purpose MoPowered datasource
 */
@interface MoDataSource : TTSectionedDataSource {
    
}

@end

/**
 * fix for styledtext cell's top corners roundlessness
 */
@interface ClearBackgroundTTStyledTextTableItemCell : 
TTStyledTextTableItemCell 
@end 

