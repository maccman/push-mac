//
//  AppDelegate.h
//  Stripe Push
//
//  Created by Alex MacCaw on 12/18/12.
//  Copyright (c) 2012 Stripe. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate> {
    IBOutlet NSMenu *statusMenu;
    NSStatusItem *statusItem;
}

@property (assign) IBOutlet NSWindow *window;

@end
