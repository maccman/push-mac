//
//  StripeConnect.m
//  Stripe Push
//
//  Created by Alex MacCaw on 12/18/12.
//  Copyright (c) 2012 Stripe. All rights reserved.
//

#import "StripeConnect.h"
#import "Constants.h"
#import "User.h"

@implementation StripeConnect

@synthesize webView, url;

- (id) init {
    self = [super initWithWindowNibName:@"StripeConnect"];
    
    NSString* deviceToken = [User sharedUser].deviceToken;
    
    
    NSString* endpoint = [NSString
                          stringWithFormat:@"%@%@%@",
                          kEndpoint,
                          @"/auth?device_token=",
                          deviceToken];
    
    self.url = [NSURL URLWithString:endpoint];
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
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
        
        [[User sharedUser] load:^(User *user, NSError *error) {
            if (error) {
                NSLog(@"Error loading user: %@", error);
            } else {
                NSLog(@"User authorized");
                [User sharedUser].authorized = true;
            }
        }];
    }
}


@end