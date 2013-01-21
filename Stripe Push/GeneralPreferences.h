#import <Cocoa/Cocoa.h>
#import "MASPreferencesViewController.h"
#import "User.h"

@interface GeneralPreferences : NSViewController <MASPreferencesViewController>

@property IBOutlet NSPopUpButton* chargeNotifications;
@property IBOutlet NSPopUpButton* transferNotifications;
@property (readonly) User* user;

@end
