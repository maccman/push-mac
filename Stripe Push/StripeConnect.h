//
//  StripeConnect.h
//  Stripe Push
//
//  Created by Alex MacCaw on 12/18/12.
//  Copyright (c) 2012 Stripe. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>

@interface StripeConnect : NSWindowController {
}

- (id) initWithToken: (NSString *)deviceToken;

@property (retain) IBOutlet WebView *webView;
@property (retain) NSURL * url;

@end
