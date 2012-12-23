//
//  AccountPreferences.h
//  Stripe Push
//
//  Created by Alex MacCaw on 12/21/12.
//  Copyright (c) 2012 Stripe. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MASPreferencesViewController.h"
#import "User.h"

@interface AccountPreferences : NSViewController <MASPreferencesViewController>

@property (readonly) User* user;
@property IBOutlet NSButton* authToggleButton;

- (IBAction)authToggle:(id)sender;

@end