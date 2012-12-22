//
//  StatusMenu.h
//  Stripe Push
//
//  Created by Alex MacCaw on 12/18/12.
//  Copyright (c) 2012 Stripe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MASPreferencesWindowController.h"

@interface StatusMenu : NSObject

- (IBAction) openPreferences:(id)sender;
- (IBAction) quit:(id)sender;

@property (readwrite, retain) NSWindowController* stripeConnect;
@property (readwrite, retain) MASPreferencesWindowController* preferences;

@end
