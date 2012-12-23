//
//  GeneralPreferences.h
//  Stripe Push
//
//  Created by Alex MacCaw on 12/21/12.
//  Copyright (c) 2012 Stripe. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MASPreferencesViewController.h"
#import "User.h"

@interface GeneralPreferences : NSViewController <MASPreferencesViewController>

@property IBOutlet NSPopUpButton* chargeNotifications;
@property IBOutlet NSPopUpButton* transferNotifications;
@property (readonly) User* user;

@end
