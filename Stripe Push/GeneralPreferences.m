//
//  GeneralPreferences.m
//  Stripe Push
//
//  Created by Alex MacCaw on 12/21/12.
//  Copyright (c) 2012 Stripe. All rights reserved.
//

#import "GeneralPreferences.h"
#import "Client.h"

#define chargeValues @[@0, @100, @200, @400, @800, @2000, @5000, @-1]
#define transferValues @[@0, @-1]

@implementation GeneralPreferences

@synthesize chargeNotifications, transferNotifications;

- (id)init
{
    return [super initWithNibName:@"GeneralPreferences" bundle:nil];
}

#pragma mark -
#pragma mark MASPreferencesViewController

- (void) awakeFromNib {
    [[Client sharedClient] getPreferences:^(NSDictionary *params, NSError *error) {
        if (error) {
            NSLog(@"Error getting preferences: %@", error);
            return;
        }
        
        NSInteger chargeIndex = [chargeValues indexOfObject:[params objectForKey:@"charge_notifications"]];
        [self.chargeNotifications selectItemAtIndex:chargeIndex];

        NSInteger transferIndex = [transferValues indexOfObject:[params objectForKey:@"transfer_notifications"]];
        [self.transferNotifications selectItemAtIndex:transferIndex];
    }];
}

- (NSString *)identifier
{
    return @"GeneralPreferences";
}

- (NSImage *)toolbarItemImage
{
    return [NSImage imageNamed:NSImageNamePreferencesGeneral];
}

- (NSString *)toolbarItemLabel
{
    return @"General";
}

- (void) updatePreferences {
    
    NSInteger chargeIndex = [self.chargeNotifications indexOfSelectedItem];
    NSNumber *chargeValue = [chargeValues objectAtIndex:chargeIndex];

    NSInteger transferIndex = [self.transferNotifications indexOfSelectedItem];
    NSNumber *transferValue = [transferValues objectAtIndex:transferIndex];
    
    NSDictionary *params = @{@"charge_notifications": chargeValue, @"transfer_notifications": transferValue};
    
    [[Client sharedClient] updatePreferences:params block:^(NSError *error) {
        NSLog(@"Error updating preferences: %@", error);
    }];
}

- (BOOL) commitEditing {
    [self updatePreferences];
    return[super commitEditing];
}

@end
