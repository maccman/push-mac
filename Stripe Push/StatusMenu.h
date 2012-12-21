//
//  StatusMenu.h
//  Stripe Push
//
//  Created by Alex MacCaw on 12/18/12.
//  Copyright (c) 2012 Stripe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StatusMenu : NSObject

- (IBAction) preferences:(id)sender;

@property (readwrite, retain) NSWindowController* stripeConnect;

@end
