//
//  NewsDataSource.m
//  MoLease
//
//  Created by Chris Voss on 2/19/11.
//  Copyright 2011 Chris Voss. All rights reserved.
//

#import "NewsDataSource.h"
#import "NewsModel.h"


@implementation NewsDataSource

- (id)init {
	if (self == [super init]) {
		_newsModel = [[NewsModel alloc] init];
	}
	return self;
}

- (id<TTModel>)model {
	return _newsModel;
}

- (void)tableViewDidLoadModel:(UITableView*)tableView {
    TTDINFO(@"News DataSource setting table items");
	self.items = [NSMutableArray array];
    
    NSLog(@"items are %@", [_newsModel.news description]);

	for (NSDictionary* _newsEntry in _newsModel.news) {        
        NSDateFormatter *_df = [[NSDateFormatter alloc] init];
        [_df setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
        NSDate *_theDate = [_df dateFromString: [_newsEntry objectForKey:@"date"]];
        TT_RELEASE_SAFELY(_df);
        
        TTTableMessageItem *_tableItem = [TTTableMessageItem itemWithTitle:[_newsEntry objectForKey:@"title"] 
                                                                   caption:@"from the blog"
                                                                      text:[_newsEntry objectForKey:@"body"] 
                                                                 timestamp:_theDate
                                                                       URL:[_newsEntry objectForKey:@"link"]];
        /*
         // attachments for future updates if we need thumbnail images from the post
        NSArray *_attachments = [_newsEntry objectForKey:@"attachments"];
        TTDINFO(@"Attachments: %@", [_attachments description]);
        if ([_attachments count] > 0) {
            //     NSDictionary *_images = [[_attachments objectAtIndex:0] objectForKey:@"images"];
            _tableItem.imageURL = [[_attachments objectAtIndex:0] objectForKey:@"url"];
            //_tableItem.imageURL = [[_images objectForKey:@"thumbnail"] objectForKey:@"url"];
        }
         */
        
		[self.items addObject:_tableItem];
        
	}
	
    
}


@end
