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
@end