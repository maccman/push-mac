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
#import "User.h"

@implementation StatusMenu

- (void)awakeFromNib {
    if ( ![User sharedUser].authorized ) {
        [self openAccountPreferences];
    }
}

- (IBAction)openPreferences:(id)sender {
    if (!preferences) {
        NSViewController *generalPreferences = [[GeneralPreferences alloc] init];
        NSViewController *accountPreferences = [[AccountPreferences alloc] init];
        NSArray *controllers = [[NSArray alloc] initWithObjects:generalPreferences, accountPreferences, nil];
        preferences = [[MASPreferencesWindowController alloc] initWithViewControllers:controllers title:@"Preferences"];
    }
    [NSApp activateIgnoringOtherApps:YES];
    [preferences selectControllerAtIndex:0];
    [preferences showWindow:nil];
}

- (void)openAccountPreferences {
    [self openPreferences:nil];
    [preferences selectControllerAtIndex:1];
}

@end
