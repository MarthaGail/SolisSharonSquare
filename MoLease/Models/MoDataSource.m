//
//  MoDataSource.m
//  MoLease
//
//  Created by Chris Voss on 4/9/11.
//  Copyright 2011 Chris Voss. All rights reserved.
//

#import "MoDataSource.h"


@implementation MoDataSource

- (Class)tableView:(UITableView*)tableView cellClassForObject:(id) object 
{ 
    if ([object isKindOfClass:[TTTableStyledTextItem class]]) { 
        return [ClearBackgroundTTStyledTextTableItemCell class]; 
    } 
    else { 
        return [super tableView:tableView cellClassForObject:object]; 
    } 
} 

@end

@implementation ClearBackgroundTTStyledTextTableItemCell 
-(void) didMoveToSuperview{ 
    [super didMoveToSuperview]; 
    if(self.superview){ 
        _label.backgroundColor = [UIColor clearColor]; 
    } 
} 

@end 