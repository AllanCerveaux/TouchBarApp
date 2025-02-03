#import <AppKit/AppKit.h>

@interface NSTouchBar (Private)
/* macOS 10.14+ */
+ (void)presentSystemModalTouchBar:(nullable NSTouchBar *)touchBar placement:(long long)placement systemTrayItemIdentifier:(nullable NSTouchBarItemIdentifier)identifier;
+ (void)dismissSystemModalTouchBar:(nullable NSTouchBar *)touchBar;
+ (void)minimizeSystemModalTouchBar:(nullable NSTouchBar *)touchBar;
@end

@interface NSFunctionRow : NSObject
+ (void)markActiveFunctionRowsAsDimmed:(BOOL)arg1;
+ (nonnull NSArray *)activeFunctionRows;
@end
