#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>

@interface StripeConnect : NSWindowController
@property NSURL* url;
@property IBOutlet WebView* webView;
@end
