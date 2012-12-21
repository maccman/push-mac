//
//  StatusMenu.m
//  Stripe Push
//
//  Created by Alex MacCaw on 12/18/12.
//  Copyright (c) 2012 Stripe. All rights reserved.
//

#import "StatusMenu.h"
#import "StripeConnect.h"

@implementation StatusMenu

@synthesize stripeConnect;

- authenticate {
    if (self.stripeConnect == nil) {
        NSString* deviceToken = [[NSUserDefaults standardUserDefaults] stringForKey:@"deviceToken"];
        self.stripeConnect = [[StripeConnect alloc] initWithToken: deviceToken];
    }
    [self.stripeConnect showWindow:nil];
}

- (IBAction)preferences:(id)sender {
    
}

@end
