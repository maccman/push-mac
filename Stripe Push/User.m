//
//  User.m
//  Stripe Push
//
//  Created by Alex MacCaw on 12/22/12.
//  Copyright (c) 2012 Stripe. All rights reserved.
//

#import "User.h"
#import "Client.h"
#import "StripeConnect.h"

@implementation User

static User *_sharedUser = nil;
static dispatch_once_t onceToken;

+ (User *)sharedUser {
    dispatch_once(&onceToken, ^{
        _sharedUser = [[User alloc] init];
    });
    
    return _sharedUser;
}

+ (void) setSharedUser:(User*)user {
    dispatch_once(&onceToken, ^{
        _sharedUser = user;
    });
}

@synthesize email, uid, chargeNotifications, transferNotifications, deviceToken, authorized;

- (void) update:(NSDictionary *)attrs {
    self.uid                   = [attrs valueForKey:@"uid"];
    self.email                 = [attrs valueForKey:@"email"];
    self.chargeNotifications   = [attrs valueForKey:@"charge_notifications"];
    self.transferNotifications = [attrs valueForKey:@"transfer_notifications"];
}

- (void)load:(void (^)(User *user, NSError *error))block {
    [[Client sharedClient] getPath:@"/user"
                        parameters:nil
                           success:^(AFHTTPRequestOperation *operation, id JSON) {
                               [self update:JSON];
                               if (block) block(self, nil);
                           } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                               NSLog(@"Error getting preferences: %@", error);
                               if (block) block(self, error);
                           }];
}

- (void) saveSelf: (void (^)(NSError *error))block {
    NSDictionary *params = @{
        @"charge_notifications": self.chargeNotifications,
        @"transfer_notifications": self.transferNotifications
    };
    
    [self save:params block:block];
}

- (void)save:(NSDictionary*)params block:(void (^)(NSError *error))block {
    [[Client sharedClient] putPath:@"/user"
                     parameters:params
                        success:^(AFHTTPRequestOperation *operation, id JSON) {
                            [self update:JSON];
                            block(nil);
                        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                            block(error);
                        }];
}

- (void)deauthorize:(void (^)(NSError *error))block {
    [[Client sharedClient] deletePath:@"/auth" parameters:@{@"deviceToken": self.deviceToken} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.authorized = false;
        self.email = nil;
        if (block) block(nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) block(error);
    }];
}

- (void)authorize:(void (^)(NSError *error))block {
    if (!stripeConnect) {
        stripeConnect = [[StripeConnect alloc] init];
    }
    [stripeConnect showWindow:self];
}

// Persistance

- (id) initWithCoder: (NSCoder *)coder
{
    if (self = [super init])
    {
        self.uid = [coder decodeObjectForKey:@"uid"];
        self.email = [coder decodeObjectForKey:@"email"];
        self.chargeNotifications = [coder decodeObjectForKey:@"chargeNotifications"];
        self.transferNotifications = [coder decodeObjectForKey:@"transferNotifications"];
        self.deviceToken = [coder decodeObjectForKey:@"deviceToken"];
        self.authorized = [coder decodeBoolForKey:@"authorized"];
    }
    return self;
}

- (void) encodeWithCoder: (NSCoder *)coder
{
    [coder encodeObject: self.uid forKey:@"uid"];
    [coder encodeObject: self.email forKey:@"email"];
    [coder encodeObject: self.chargeNotifications forKey:@"chargeNotifications"];
    [coder encodeObject: self.transferNotifications forKey:@"transferNotifications"];
    [coder encodeObject: self.deviceToken forKey:@"deviceToken"];
    [coder encodeBool: self.authorized forKey:@"authorized"];
}

@end
