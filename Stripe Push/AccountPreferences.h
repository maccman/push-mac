#import <Cocoa/Cocoa.h>
#import "MASPreferencesViewController.h"
#import "User.h"

@interface AccountPreferences : NSViewController <MASPreferencesViewController>

@property (readonly) User* user;
@property IBOutlet NSButton* authToggleButton;
@property IBOutlet NSTextField* versionLabel;

- (IBAction)authToggle:(id)sender;

@end