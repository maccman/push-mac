#import <Foundation/Foundation.h>
@class StripeConnect;

@interface User : NSObject <NSCoding> {
@private
    StripeConnect* stripeConnect;
}

+ (User *)sharedUser;
+ (void) setSharedUser:(User*)user;

@property NSString* email;
@property NSString* uid;
@property NSNumber* chargeNotifications;
@property NSNumber* transferNotifications;
@property NSString* deviceToken;
@property Boolean authorized;

- (void) update:(NSDictionary*)attrs;
- (void)load:(void (^)(User *user, NSError *error))block;
- (void)saveSelf: (void (^)(NSError *error))block;
- (void)save:(NSDictionary*)params block:(void (^)(NSError *error))block;
- (void)deauthorize:(void (^)(NSError *error))block;
- (void)authorize:(void (^)(NSError *error))block;

@end
