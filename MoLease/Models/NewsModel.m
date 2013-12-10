//
//  News.m
//  MoLease
//
//  Created by Chris Voss on 2/19/11.
//  Copyright 2011 Chris Voss. All rights reserved.
//

#import "NewsModel.h"
#import <extThree20XML/extThree20XML.h>


@implementation NewsModel

@synthesize news = _news;

- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more {
    TTDINFO(@"loading news feed");
	if (!self.isLoading) {
        NSString* url = NSLocalizedString(@"BLOG URL", @"blog url");
        
        TTURLRequest* request = [TTURLRequest requestWithURL: url delegate: self];
        
        TTURLXMLResponse *response = [[TTURLXMLResponse alloc] init];
        response.isRssFeed = YES;
        
		request.response = response;
		TT_RELEASE_SAFELY(response);
        
		[request send];
	}
}

- (void)requestDidFinishLoad:(TTURLRequest*)request {
	TTURLXMLResponse* response = request.response;
	TTDASSERT([response.rootObject isKindOfClass:[NSDictionary class]]);
    response.isRssFeed = YES;
    TT_RELEASE_SAFELY(_news);
    
    TTDINFO(@"class is %@", [[[response.rootObject objectForKey:@"channel"] objectForKey:@"item"] class]);
    if ([[[response.rootObject objectForKey:@"channel"] objectForKey:@"item"] isKindOfClass:[NSArray class]]) {
        
        NSArray *theItems = [[response.rootObject objectForKey:@"channel"] objectForKey:@"item"];
        
        NSMutableArray* _allNews = [[NSMutableArray alloc] init];
        
        for (NSDictionary *theItem in theItems) {
            NSString *theTitle = [[theItem objectForKey:@"title"] objectForKey:@"___Entity_Value___"];
            TTDINFO(@"title is %@", theTitle);
            NSString *theBody = [[theItem objectForKey:@"description"] objectForKey:@"___Entity_Value___"];
            TTDINFO(@"description is %@", theBody);
            NSString *theDate = [[theItem objectForKey:@"pubDate"] objectForKey:@"___Entity_Value___"];
            TTDINFO(@"date is %@", theDate);
            NSString *theLink = [[theItem objectForKey:@"link"] objectForKey:@"___Entity_Value___"];
            TTDINFO(@"link is %@", theLink);
            
            NSDictionary *theDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:[theTitle retain], @"title",
                                           [theBody stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding], @"body",
                                           theDate, @"date",
                                           theLink, @"link",
                                           nil];
            TTDINFO(@"News dictionary item: %@", [theDictionary description]);
            [_allNews addObject:theDictionary];
        }
        _news = _allNews;
    } else {
        
        // there is only 1 blog post

        NSDictionary *theItem = [[response.rootObject objectForKey:@"channel"] objectForKey:@"item"];
        
        NSMutableArray* _allNews = [[NSMutableArray alloc] init];
        
            NSString *theTitle = [[theItem objectForKey:@"title"] objectForKey:@"___Entity_Value___"];
            TTDINFO(@"title is %@", theTitle);
            NSString *theBody = [[theItem objectForKey:@"description"] objectForKey:@"___Entity_Value___"];
            TTDINFO(@"description is %@", theBody);
            NSString *theDate = [[theItem objectForKey:@"pubDate"] objectForKey:@"___Entity_Value___"];
            TTDINFO(@"date is %@", theDate);
            NSString *theLink = [[theItem objectForKey:@"link"] objectForKey:@"___Entity_Value___"];
            TTDINFO(@"link is %@", theLink);
            
            NSDictionary *theDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:[theTitle retain], @"title",
                                           [theBody stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding], @"body",
                                           theDate, @"date",
                                           theLink, @"link",
                                           nil];
            TTDINFO(@"News dictionary item: %@", [theDictionary description]);
            [_allNews addObject:theDictionary];
        
        _news = _allNews;
    }
    
	[super requestDidFinishLoad:request];
}

#pragma mark - TTURLRequestDelegate
- (void)request:(TTURLRequest *)request didFailLoadWithError:(NSError *)error {
    TTDERROR(@"******************** error with %@", [error description]);
}

- (BOOL)isLoadingMore {
	return NO;
}

- (BOOL)isOutdated {
	return NO;
}

- (BOOL)isLoaded {
	return !!_news;
}

- (BOOL)isLoading {
    // TODO: This might not be the best way to handle. Test with no connection
    return [super isLoading];
}

- (BOOL)isEmpty {
	return !_news.count;
}

- (void)invalidate:(BOOL)erase {
}



@end
