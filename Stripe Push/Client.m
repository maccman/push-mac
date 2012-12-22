//
//  Client.m
//  Stripe Push
//
//  Created by Alex MacCaw on 12/21/12.
//  Copyright (c) 2012 Stripe. All rights reserved.
//

#import "Client.h"
#import "Constants.h"
#import "AFJSONRequestOperation.h"

@implementation Client

+ (Client *)sharedClient {
    static Client *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[Client alloc] initWithBaseURL:[NSURL URLWithString:kEndpoint]];
    });
    
    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];    
	[self setDefaultHeader:@"Accept" value:@"application/json"];
    
    return self;
}

- (void)getPreferences: (void (^)(NSDictionary *params, NSError *error))block {
    [[Client sharedClient] getPath:@"/user"
                        parameters:nil
                           success:^(AFHTTPRequestOperation *operation, id JSON) {
                               block(JSON, nil);
                           } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                               block(nil, error);
                           }];
}

- (void)updatePreferences:(NSDictionary *)params block:(void (^)(NSError *error))block {
    [[Client sharedClient] putPath:@"/user"
                        parameters:params
                           success:^(AFHTTPRequestOperation *operation, id JSON) {
                               block(nil);
                           } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                               block(error);
                           }];
}

@end
