//
//  StripeConnect.h
//  Stripe Push
//
//  Created by Alex MacCaw on 12/22/12.
//  Copyright (c) 2012 Stripe. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>

@interface StripeConnect : NSWindowController
@property NSURL* url;
@property IBOutlet WebView* webView;
@end
