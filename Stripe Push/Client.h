#import <Foundation/Foundation.h>
#import "AFHTTPClient.h"

@interface Client : AFHTTPClient
+ (Client *)sharedClient;
@end