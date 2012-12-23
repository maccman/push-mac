//
//  GeneralPreferences.m
//  Stripe Push
//
//  Created by Alex MacCaw on 12/21/12.
//  Copyright (c) 2012 Stripe. All rights reserved.
//

#import "GeneralPreferences.h"
#import "Client.h"
#import "User.h"

@implementation GeneralPreferences

@synthesize chargeNotifications, transferNotifications;

- (id)init
{
    return [super initWithNibName:@"GeneralPreferences" bundle:nil];
}

#pragma mark -
#pragma mark MASPreferencesViewController

- (void) awakeFromNib {
    if (self.user.authorized)
        [self.user load:^(User *user, NSError *error) {
            if (error) {
                NSLog(@"Error loading user: %@", error);
            } else {
                NSLog(@"Loaded user: %@", user);
            }
        }];
}

- (User*) user {
    return [User sharedUser];
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

- (BOOL) commitEditing {
    if (self.user.authorized) {
        NSLog(@"Saving user");

        [self.user saveSelf:^(NSError *error) {
            NSLog(@"Saved user");
            if (error) {
                NSLog(@"Error updating user: %@", error);
            }
        }];
    }

    return[super commitEditing];
}

@end
