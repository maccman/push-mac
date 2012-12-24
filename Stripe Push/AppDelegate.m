//
//  AppDelegate.m
//  Stripe Push
//
//  Created by Alex MacCaw on 12/18/12.
//  Copyright (c) 2012 Stripe. All rights reserved.
//

#import "AppDelegate.h"
#import "User.h"
#import "NSFileManager+DirectoryLocations.h"

@implementation AppDelegate

- (void)awakeFromNib {
    [self loadData];
}

- (void) applicationWillTerminate:(NSNotification *)notification {
    NSLog(@"Going to save data");
    [self saveData];
}

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

- (void)application:(NSApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceTokenData {

    NSString* deviceToken = [deviceTokenData description];

    deviceToken = [deviceToken stringByReplacingOccurrencesOfString:@"[ <>]"
                                                         withString:@""
                                                            options:NSRegularExpressionSearch
                                                              range:NSMakeRange(0, deviceToken.length)];

    [User sharedUser].deviceToken = deviceToken;
    NSLog(@"Got device token: %@", [User sharedUser].deviceToken);
}

- (void)application:(NSApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    NSLog(@"Got notification: %@", [userInfo description]);
}

- (BOOL)userNotificationCenter:(NSUserNotificationCenter *)center shouldPresentNotification:(NSUserNotification *)notification {
    return YES;
}

- (NSString*) dataPath {
    NSString *path = [[NSFileManager defaultManager] applicationSupportDirectory];
    return [path stringByAppendingPathComponent:@"data.plist"];
}

- (void) saveData {
    [NSKeyedArchiver archiveRootObject: [User sharedUser] toFile: [self dataPath]];
    NSLog(@"Saved user: %@", [User sharedUser].email);
}

- (void) loadData {
    User* user = [NSKeyedUnarchiver unarchiveObjectWithFile: [self dataPath]];
    if (user) [User setSharedUser:user];
    NSLog(@"Loaded user: %@", [User sharedUser].email);
}

@end
