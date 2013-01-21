//
//  AccountPreferences.m
//  Stripe Push
//
//  Created by Alex MacCaw on 12/21/12.
//  Copyright (c) 2012 Stripe. All rights reserved.
//

#import "AccountPreferences.h"
#import "User.h"

@implementation AccountPreferences

@synthesize versionLabel, authToggleButton;

- (id)init
{
    return [super initWithNibName:@"AccountPreferences" bundle:nil];
}

- (void) awakeFromNib {
    NSString *appName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"];
    NSString *appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    [self.versionLabel setStringValue:[NSString stringWithFormat:@"%@ v%@", appName, appVersion]];
    
    [self setAuthToggleButtonTitle];
    [self.user addObserver:self forKeyPath:@"authorized" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    [self setAuthToggleButtonTitle];
}

- (void) setAuthToggleButtonTitle {
    if (self.user.authorized) {
        [self.authToggleButton setTitle:@"Unlink this computer..."];
    } else {
        [self.authToggleButton setTitle:@"Link this computer..."];
    }
}

#pragma mark -
#pragma mark MASPreferencesViewController

- (NSString *)identifier
{
    return @"AccountPreferences";
}

- (NSImage *)toolbarItemImage
{
    return [NSImage imageNamed:@"user"];
}

- (NSString *)toolbarItemLabel
{
    return @"Account";
}

- (User *)user {
    return [User sharedUser];
}

- (IBAction)authToggle:(id)sender {
    if (self.user.authorized) {
        [self.user deauthorize:nil];
    } else {
        [self.user authorize:nil];
    }
}

@end
