//
//  StripeConnect.m
//  Stripe Push
//
//  Created by Alex MacCaw on 12/18/12.
//  Copyright (c) 2012 Stripe. All rights reserved.
//

#import "StripeConnect.h"
#import "Constants.h"

@interface StripeConnect ()

@end

@implementation StripeConnect

@synthesize webView, url;

- (id) initWithToken: (NSString *)deviceToken {
    self = [super initWithWindowNibName:@"StripeConnect"];
    
    NSString* strippedDeviceToken = [deviceToken
                                     stringByReplacingOccurrencesOfString: @"[ <>]"
                                     withString:@""
                                     options:NSRegularExpressionSearch
                                     range:NSMakeRange(0, deviceToken.length)];
    
    NSString* endpoint = [NSString
                          stringWithFormat:@"%@%@%@",
                          kEndpoint,
                          @"/auth?device_token=",
                          strippedDeviceToken];
    
    self.url = [NSURL URLWithString:endpoint];
        
    [self.window setFrame: NSMakeRect(0,0,850,490) display: YES];
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage
                                          sharedHTTPCookieStorage];
    [cookieStorage setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyAlways];
    
    if (self.url != nil) {
        [self.webView setMainFrameURL:[self.url absoluteString]];
    }

}

- (void)webView:(WebView *)sender didFinishLoadForFrame:(WebFrame *)frame {
    NSString* endpoint = [NSString stringWithFormat:@"%@%@", kEndpoint, @"/auth/complete"];
    
    NSLog(@"didFinishLoad: %@", [sender mainFrameURL]);
    
    if ([[sender mainFrameURL] isEqualToString:endpoint]) {
        // We've authenticated
        [self close];
    }
}


@end
