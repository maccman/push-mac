#import <Foundation/Foundation.h>
#import "MASPreferencesWindowController.h"

@interface StatusMenu : NSObject {
@private
MASPreferencesWindowController* preferences;
}

- (IBAction) openPreferences:(id)sender;
- (void) openAccountPreferences;

@end
