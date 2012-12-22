//
//  StatusMenu.m
//  Stripe Push
//
//  Created by Alex MacCaw on 12/18/12.
//  Copyright (c) 2012 Stripe. All rights reserved.
//

#import "StatusMenu.h"
#import "StripeConnect.h"
#import "GeneralPreferences.h"
#import "AccountPreferences.h"
#import "MASPreferencesWindowController.h"

@implementation StatusMenu

@synthesize stripeConnect;

- authenticate {
    if (self.stripeConnect == nil) {
        NSString* deviceToken = [[NSUserDefaults standardUserDefaults] stringForKey:@"deviceToken"];
        self.stripeConnect = [[StripeConnect alloc] initWithToken: deviceToken];
    }
    [self.stripeConnect showWindow:nil];
}

- (IBAction)openPreferences:(id)sender {
    if (self.preferences == nil) {
        NSViewController *generalPreferences = [[GeneralPreferences alloc] init];
        NSViewController *accountPreferences = [[AccountPreferences alloc] init];
        NSArray *controllers = [[NSArray alloc] initWithObjects:generalPreferences, accountPreferences, nil];
        self.preferences = [[MASPreferencesWindowController alloc] initWithViewControllers:controllers title:@"Preferences"];
    }
    [self.preferences selectControllerAtIndex:0];
    [self.preferences showWindow:nil];
}

- (IBAction)quit:(id)sender {
    [NSApp terminate: nil];
}

@end
