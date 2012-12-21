//
//  AppDelegate.m
//  Stripe Push
//
//  Created by Alex MacCaw on 12/18/12.
//  Copyright (c) 2012 Stripe. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [self activateStatusMenu];
    [[NSUserNotificationCenter defaultUserNotificationCenter] setDelegate:(id)self];
    [[NSApplication sharedApplication] registerForRemoteNotificationTypes:NSRemoteNotificationTypeAlert];
}

- (void) activateStatusMenu {
    NSStatusBar *bar = [NSStatusBar systemStatusBar];
    statusItem = [bar statusItemWithLength:NSVariableStatusItemLength];
    [statusItem setTitle:@"Stripe"];
    [statusItem setHighlightMode:YES];
    [statusItem setMenu:statusMenu];
}

- (void)application:(NSApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"Error in registration. Error: %@", error);
}

- (void)application:(NSApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"Got device token: %@", [deviceToken description]);
    [[NSUserDefaults standardUserDefaults] setObject:[deviceToken description] forKey:@"deviceToken"];
}

- (void)application:(NSApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    NSLog(@"Got notification: %@", [userInfo description]);
}

- (BOOL)userNotificationCenter:(NSUserNotificationCenter *)center shouldPresentNotification:(NSUserNotification *)notification {
    return YES;
}

@end
