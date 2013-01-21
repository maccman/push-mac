//
//  StatusMenu.h
//  Stripe Push
//
//  Created by Alex MacCaw on 12/18/12.
//  Copyright (c) 2012 Stripe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MASPreferencesWindowController.h"

@interface StatusMenu : NSObject {
@private
MASPreferencesWindowController* preferences;
}

- (IBAction) openPreferences:(id)sender;
- (void) openAccountPreferences;

@end
