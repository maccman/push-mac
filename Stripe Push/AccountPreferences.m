//
//  AccountPreferences.m
//  Stripe Push
//
//  Created by Alex MacCaw on 12/21/12.
//  Copyright (c) 2012 Stripe. All rights reserved.
//

#import "AccountPreferences.h"

@implementation AccountPreferences

- (id)init
{
    return [super initWithNibName:@"AccountPreferences" bundle:nil];
}

- (void) windowDidLoad {
    NSLog(@"window loaded");
}

#pragma mark -
#pragma mark MASPreferencesViewController

- (NSString *)identifier
{
    return @"AccountPreferences";
}

- (NSImage *)toolbarItemImage
{
    return [NSImage imageNamed:NSImageNamePreferencesGeneral];
}

- (NSString *)toolbarItemLabel
{
    return @"Account";
}

- (BOOL) commitEditing {
//    Send rest request
    return[super commitEditing];
}

@end
