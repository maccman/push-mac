//
//  Client.h
//  Stripe Push
//
//  Created by Alex MacCaw on 12/21/12.
//  Copyright (c) 2012 Stripe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPClient.h"

@interface Client : AFHTTPClient
+ (Client *)sharedClient;
- (void)getPreferences: (void (^)(NSDictionary *params, NSError *error))block;
- (void)updatePreferences:(NSDictionary *)params block:(void (^)(NSError *error))block;
@end